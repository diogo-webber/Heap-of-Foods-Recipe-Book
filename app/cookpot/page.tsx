"use client"

import { useState, useMemo } from "react"
import recipes from "@/data/recipes_cookpot.json"
import { t } from "@/lib/i18n"

const PERISH_MAP = {
  PERISH_SUPERFAST: 1440,
  PERISH_FAST: 2880,
  PERISH_FASTISH: 3840,
  PERISH_MED: 4800,
  PERISH_SLOW: 7200,
  PERISH_PRESERVED: 9600,
  PERISH_SUPERSLOW: 19200
}

const SPOILAGE_LABELS = {
  PERISH_SUPERFAST: t("spoilagetime.superfast"),
  PERISH_FAST: t("spoilagetime.fast"),
  PERISH_FASTISH: t("spoilagetime.fastish"),
  PERISH_MED: t("spoilagetime.med"),
  PERISH_SLOW: t("spoilagetime.slow"),
  PERISH_PRESERVED: t("spoilagetime.preserved"),
  PERISH_SUPERSLOW: t("spoilagetime.superslow")
}

const TEMPERATURE_DURATION_MAP = {
  FOOD_TEMP_BRIEF: 5,
  FOOD_TEMP_AVERAGE: 10,
  FOOD_TEMP_LONG: 15,
  FOOD_TEMP_DURATION: 480
}

interface SortOptionProps {
  value: string
  label: string
  current: string
  onChange: (val: string) => void
}

const SortOption = ({ value, label, current, onChange }: SortOptionProps) => (
  <label className="flex items-center gap-3 cursor-pointer text-sm text-zinc-300 hover:text-white transition-colors">
    <div
      className={`w-5 h-5 border-2 rounded flex items-center justify-center transition ${
        current === value ? "bg-gray-500 border-gray-500" : "border-zinc-400 bg-zinc-900"
      }`}
    >
      {current === value && <span className="text-white text-sm font-black">✔</span>}
    </div>
    <input type="radio" className="hidden" checked={current === value} onChange={() => onChange(value)} />
    {label}
  </label>
)

export default function CookPot() {
  const [selected, setSelected] = useState<any>(null)

  const [sidebarOpen, setSidebarOpen] = useState(true)
  const [filtersOpen, setFiltersOpen] = useState(true)
  
  const [sortingOpen, setSortingOpen] = useState(false)
  const [sortType, setSortType] = useState("default")
  const [sortDirection, setSortDirection] = useState<"asc" | "desc">("asc")

  const [filterTemp, setFilterTemp] = useState<string | null>(null)
  const [filterDebuff, setFilterDebuff] = useState<boolean | null>(null)
  const [filterFoodType, setFilterFoodType] = useState<string | null>(null)

  const filteredRecipes = recipes.filter((recipe: any) => {
    if (filterTemp !== null) {
      if (filterTemp === "hot" && recipe.temperature <= 0) return false
      if (filterTemp === "cold" && recipe.temperature >= 0) return false
    }

    if (filterDebuff !== null) {
      if (recipe.debuff !== filterDebuff) return false
    }

    if (filterFoodType !== null) {
      if (recipe.foodtype !== filterFoodType) return false
    }

    return true
  })

  const invertOrderFor = ["health", "hunger", "sanity"]

  const sortedRecipes = useMemo(() => {
    let arr = [...filteredRecipes]

    if (sortType === "default") return arr

    const isInverted = invertOrderFor.includes(sortType)

    const directionMultiplier =
      sortDirection === "asc"
        ? (isInverted ? -1 : 1)
        : (isInverted ? 1 : -1)

    arr.sort((a: any, b: any) => {
      let valA: any
      let valB: any

      switch (sortType) {
        case "alphabet":
          valA = t(`recipes.${a.name}`) ?? ""
          valB = t(`recipes.${b.name}`) ?? ""
          return valA.localeCompare(valB) * directionMultiplier

        case "spoilage":
          valA = a.spoilage ?? 0
          valB = b.spoilage ?? 0
          break

        default:
          valA = a[sortType] ?? 0
          valB = b[sortType] ?? 0
          break
      }

      return (valA - valB) * directionMultiplier
    })

    return arr
  }, [filteredRecipes, sortType, sortDirection])

  return (
  <div className="flex flex-1 bg-zinc-950 text-white">
    {/* SIDEBAR */}
    <aside
      className={`
        h-screen
        sticky
        top-0
        bg-zinc-900
        border-r border-zinc-800
        transition-all duration-300
        ${sidebarOpen ? "w-64" : "w-16"}
      `}
    >
      {/* SCROLL CONTAINER */}
      <div
        className={`
          h-full
          overflow-y-scroll
          overscroll-contain
          hide-scrollbar
          select-none
          ${sidebarOpen ? "p-6" : "p-3"}
        `}
        style={{
          scrollbarGutter: "stable"
        }}
      >
        <div className="flex flex-col gap-4">
          {sidebarOpen && (
            <>
            {/* FILTERS */}
            <div className="flex flex-col">
              <button
                onClick={() => setFiltersOpen(!filtersOpen)}
                className="
                  w-full
                  bg-zinc-800
                  hover:bg-zinc-700
                  rounded-xl
                  px-4 py-3
                  flex justify-between items-center
                  font-bold
                  tracking-wide
                  transition
                "
              >
                {t("filters.title")}
                <span className="text-zinc-400">
                  {filtersOpen ? "▲" : "▼"}
                </span>
              </button>

              <div
                className={`
                  overflow-hidden
                  transition-all duration-300
                  ${filtersOpen ? "max-h-[1200px] mt-3" : "max-h-0"}
                `}
              >
                <div className="bg-zinc-800 border border-zinc-800 rounded-xl p-4 flex flex-col gap-4 font-bold">

                  {/* TEMPERATURE */}
                  <div className="flex flex-col gap-1">
                    <div className="flex items-center gap-2 text-xs uppercase tracking-wider text-zinc-400">
                      <img src="/icons/icon_temperature.png" className="w-6 h-6" />
                      {t("filters.temperature")}
                    </div>

                    <div className="flex flex-col gap-2 pl-1">
                      <CheckboxFilter
                        label={t("card.temperature.hot")}
                        checked={filterTemp === "hot"}
                        onChange={() =>
                          setFilterTemp(filterTemp === "hot" ? null : "hot")
                        }
                      />
                      <CheckboxFilter
                        label={t("card.temperature.cold")}
                        checked={filterTemp === "cold"}
                        onChange={() =>
                          setFilterTemp(filterTemp === "cold" ? null : "cold")
                        }
                      />
                    </div>
                  </div>

                  <div className="w-full h-[2px] bg-white/100" />

                  {/* FOODTYPE */}
                  <div className="flex flex-col gap-1">
                    <div className="flex items-center gap-2 text-xs uppercase tracking-wider text-zinc-400">
                      <img src="/icons/icon_foodtype.png" className="w-6 h-6" />
                      {t("filters.foodtype")}
                    </div>

                    <div className="flex flex-col gap-2 pl-1">
                      {[...new Set(recipes.map((r: any) => r.foodtype))]
                        .filter(Boolean)
                        .map((type) => (
                          <CheckboxFilter
                            key={type}
                            label={t(`foodtypes.${type}`)}
                            checked={filterFoodType === type}
                            onChange={() =>
                              setFilterFoodType(
                                filterFoodType === type ? null : type
                              )
                            }
                          />
                        ))}
                    </div>
                  </div>

                  <div className="w-full h-[2px] bg-white/100" />

                  {/* DEBUFF */}
                  <div className="flex flex-col gap-1">
                    <div className="flex items-center gap-2 text-xs uppercase tracking-wider text-zinc-400">
                      <img src="/icons/icon_debuff.png" className="w-6 h-6" />
                      {t("filters.debuff.title")}
                    </div>

                    <div className="flex flex-col gap-2 pl-1">
                      <CheckboxFilter
                        label={t("filters.debuff.hasdebuff")}
                        checked={filterDebuff === true}
                        onChange={() =>
                          setFilterDebuff(filterDebuff === true ? null : true)
                        }
                      />
                    </div>
                  </div>

                  <div className="w-full h-[2px] bg-white/100" />

                  {/* CLEAR BUTTON */}
                  <button
                    onClick={() => {
                      setFilterTemp(null)
                      setFilterFoodType(null)
                      setFilterDebuff(null)
                    }}
                    className="
                      bg-zinc-700
                      hover:bg-red-700
                      rounded-lg
                      py-2
                      text-sm
                      font-bold
                      transition
                    "
                  >
                    {t("filters.clear")}
                  </button>

                </div>
              </div>
            </div>
            {/* SORT ORDER */}
            <div className="flex flex-col">
              <button
                onClick={() => setSortingOpen(!sortingOpen)}
                className="
                  w-full
                  bg-zinc-800
                  hover:bg-zinc-700
                  rounded-xl
                  px-4 py-3
                  flex justify-between items-center
                  font-bold
                  tracking-wide
                  transition
                "
              >
                {t("sorting.title")}
                <span className="text-zinc-400">
                  {sortingOpen ? "▲" : "▼"}
                </span>
              </button>

              <div
                className={`
                  overflow-hidden
                  transition-all duration-300
                  ${sortingOpen ? "max-h-[1200px] mt-3" : "max-h-0"}
                `}
              >
                <div className="bg-zinc-800 border border-zinc-800 rounded-xl p-4 flex flex-col gap-4 font-bold">

                  {/* ASC / DESC */}
                  <div className="flex flex-col gap-1">
                    <div className="flex items-center gap-2 text-xs uppercase tracking-wider text-zinc-400">
                      <img src="/icons/icon_priority.png" className="w-6 h-6" />
                        {t("sorting.directiontype")}
                      </div>
                  
                    <div className="flex flex-col gap-2 pl-1">
                      <CheckboxFilter
                        label={t("sorting.direction.up")}
                        checked={sortDirection === "asc"}
                        onChange={() => 
                          setSortDirection("asc")
                        }
                      />
                      <CheckboxFilter
                        label={t("sorting.direction.down")}
                        checked={sortDirection === "desc"}
                        onChange={() => 
                          setSortDirection("desc")
                        }
                      />
                    </div>
                  </div>

                  <div className="w-full h-[2px] bg-white/100" />

                  <div className="flex flex-col gap-1">
                    <div className="flex items-center gap-2 text-xs uppercase tracking-wider text-zinc-400">
                      <img src="/icons/icon_debuff.png" className="w-6 h-6" />
                        {t("sorting.ordertype")}
                      </div>

                    <div className="flex flex-col gap-2 pl-1">
                      <CheckboxFilter
                        label={t("sorting.type.default")}
                        checked={sortType === "default"}
                        onChange={() => setSortType("default")}
                      />
                      <CheckboxFilter
                        label={t("sorting.type.alphabet")}
                        checked={sortType === "alphabet"}
                        onChange={() => setSortType("alphabet")}
                      />
                      <CheckboxFilter
                        label={t("sorting.type.health")}
                        checked={sortType === "health"}
                        onChange={() => setSortType("health")}
                      />
                      <CheckboxFilter
                        label={t("sorting.type.hunger")}
                        checked={sortType === "hunger"}
                        onChange={() => setSortType("hunger")}
                      />
                      <CheckboxFilter
                        label={t("sorting.type.sanity")}
                        checked={sortType === "sanity"}
                        onChange={() => setSortType("sanity")}
                      />
                      <CheckboxFilter
                        label={t("sorting.type.priority")}
                        checked={sortType === "priority"}
                        onChange={() => setSortType("priority")}
                      />
                      <CheckboxFilter
                        label={t("sorting.type.cooktime")}
                        checked={sortType === "cooktime"}
                        onChange={() => setSortType("cooktime")}
                      />
                      <CheckboxFilter
                        label={t("sorting.type.spoilage")}
                        checked={sortType === "spoilage"}
                        onChange={() => setSortType("spoilage")}
                      />
                    </div>
                  </div>

                  <div className="w-full h-[2px] bg-white/100" />

                  {/* RESET BUTTON */}
                  <button
                    onClick={() => {
                      setSortType("default")
                      setSortDirection("asc")
                    }}
                    className="
                      bg-zinc-700
                      hover:bg-red-700
                      rounded-lg
                      py-2
                      text-sm
                      font-bold
                      transition
                    "
                  >
                    {t("sorting.clear")}
                  </button>
                </div>
              </div>
            </div>
          </>
          )}
        </div>
      </div>
    </aside>
 
      {/* MAIN CONTENT */}
      <main className="flex-1 p-10 select-none">
        <div className="flex items-center gap-3 mb-10">
          <img
            src="/icons/icon_cookpot.png"
            className="w-14 h-14 object-contain"
          />
          <h1 className="text-4xl font-bold">{t("title")}</h1>
        </div>

        <div className="grid grid-cols-4 gap-5 font-bold">
          {sortedRecipes.map((recipe, index) => (
            <div
              key={index}
              onClick={() => setSelected(recipe)}
              className="bg-zinc-900 rounded-2xl p-3 flex flex-col items-center gap-3 cursor-pointer hover:scale-105 transition"
            >
              <img
                src={`/foods_cookpot/${recipe.name}.png`}
                alt={recipe.name}
                className="w-24"
              />

              <h2 className="text-center font-semibold text-lg">
                {t(`recipes.${recipe.name}`)}
              </h2>

              <div className="w-full h-[2px] bg-white/100" />

              <div className="flex items-center gap-2 flex-wrap justify-center">
                {recipe.foodtype && <FoodType type={recipe.foodtype} />}

                {recipe.temperature != null && (
                  <TopEffect
                    icon="/icons/icon_temperature.png"
                    value={
                      recipe.temperature > 0
                        ? t("card.temperature.hot")
                        : t("card.temperature.cold")
                    }
                    tooltip={t("tooltips.temperature")}
                  />
                )}

                {recipe.debuff && (
                  <TopEffect
                    icon="/icons/icon_debuff.png"
                    value={t("card.debuff.hasEffect")}
                    tooltip={t("tooltips.debuff")}
                    enableTooltip={false}
                  />
                )}
              </div>
            </div>
          ))}
        </div>
      </main>
      {/* MODAL */}
      {selected && (
        <div
          className="fixed inset-0 bg-black/70 flex items-center justify-center z-50"
          onClick={() => setSelected(null)}
        >
          <div
            className="bg-zinc-900 rounded-2xl p-8 w-[750px] relative"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex justify-end">
              <button
                onClick={() => setSelected(null)}
                className="
                bg-zinc-800
                hover:bg-zinc-700
                px-3 py-1
                rounded-lg
                font-bold
                text-white
                transition-all
                duration-200
                "
              >
                {t("close")}
              </button>
            </div>

            <img
              src={`/foods_cookpot/${selected.name}.png`}
              className="w-32 mx-auto mb-4"
            />

            <h2 className="text-center text-2xl font-semibold">
              {t(`recipes.${selected.name}`)}
            </h2>

            <div className="flex justify-center my-4">
              <div className="w-100 h-0.5 bg-white/100"></div>
            </div>

            {/* FOODTYPE + EFFECTS */}
            <div className="flex justify-center items-center gap-4 mb-6 mt-2 flex-wrap font-semibold">
              {selected.foodtype && (
                <FoodType type={selected.foodtype} />
              )}

              {selected.temperature != null && (
                <TopEffect
                  icon="/icons/icon_temperature.png"
                  value={FormatTemperature(selected.temperature, selected.temperatureDuration)}
                  tooltip={t("tooltips.temperature")}
                />
              )}

              {selected.debuff && (
                <TopEffect
                  icon="/icons/icon_debuff.png"
                  value={t(`recipes_debuff.${selected.name}`)}
                  tooltip={t("tooltips.debuff")}
                />
              )}
            </div>

            {/* STATUS */}
            <Block>
              <Stat icon="/icons/icon_health.png" value={selected.health} tooltip={t("tooltips.health")} isStatus />
              <Stat icon="/icons/icon_hunger.png" value={selected.hunger} tooltip={t("tooltips.hunger")} isStatus />
              <Stat icon="/icons/icon_sanity.png" value={selected.sanity} tooltip={t("tooltips.sanity")} isStatus />
            </Block>

            <Block>
              <Stat icon="/icons/icon_priority.png" value={selected.priority}                   tooltip={t("tooltips.priority")} />
              <Stat icon="/icons/icon_cooktime.png" value={FormatCookTime(selected.cooktime)}   tooltip={t("tooltips.cooktime")} />
              <Stat icon="/icons/icon_spoilage.png" value={GetSpoilageLabel(selected.spoilage)} tooltip={t("tooltips.spoilage")} />
            </Block>

            {selected.stacksize && (
              <Block>
                <Stat
                  icon="/icons/icon_stacksize.png"
                  value={selected.stacksize}
                  tooltip={t("tooltips.stacksize")}
                />
              </Block>
            )}
          </div>
        </div>
      )}
    </div>
  )
}

/* BLOCK */
function Block({ children }: any) {
  return (
    <div className="bg-zinc-800 rounded-xl p-4 flex justify-evenly items-center mb-5 min-h-[70px]">
      {children}
    </div>
  )
}

/* STAT */
function Stat({ icon, value, tooltip, isStatus = false }: any) {
  if (value === undefined || value === null) return null

  let displayValue = value
  let colorClass = "text-zinc-200"

  if (isStatus) {
    const numericValue = Number(value)

    if (!isNaN(numericValue)) {
      if (numericValue > 0) {
        displayValue = `+${numericValue}`
        colorClass = "text-green-500"
      } else if (numericValue < 0) {
        displayValue = `-${Math.abs(numericValue)}`
        colorClass = "text-red-500"
      } else {
        displayValue = "0"
        colorClass = "text-zinc-300"
      }
    }
  }

  return (
    <div className="relative group flex items-center gap-3 min-w-[120px] justify-center">
      <img src={icon} className="w-9 h-9 object-contain" />

      <span className={`text-base font-semibold ${colorClass}`}>
        {displayValue}
      </span>

      <div className="
        absolute bottom-full mb-2
        left-1/2 -translate-x-1/2
        hidden group-hover:block
        bg-black text-white text-xs font-semibold
        px-3 py-1 rounded whitespace-nowrap
        shadow-lg z-50 pointer-events-none
      ">
        {tooltip}
      </div>
    </div>
  )
}

/* FOODTYPE */
function FoodType({ type }: any) {
  return (
    <div className="relative group flex items-center gap-2 bg-zinc-800 px-3 py-1 rounded-full text-xs tracking-wide cursor-default">
      <img
        src="/icons/icon_foodtype.png"
        className="w-5 h-5 object-contain"
      />

      {/* FOODTYPE TEXT */}
      <span className="text-zinc-300">
        {t(`foodtypes.${type}`)}
      </span>

      {/* TOOLTIP */}
      <div
        className="
          absolute bottom-full mb-2
          left-1/2 -translate-x-1/2
          hidden group-hover:block
          bg-black text-white text-xs
          px-3 py-1 rounded whitespace-nowrap
          shadow-lg z-50 pointer-events-none
        "
      >
        {t("tooltips.foodtype")}
      </div>
    </div>
  )
}

/* EFFECT */
function TopEffect({ icon, value, tooltip, enableTooltip = true }: any) {
  return (
    <div
      className={`
        relative flex items-center gap-2
        bg-zinc-800
        px-3 py-1
        rounded-full
        text-xs tracking-wide
        ${enableTooltip && tooltip ? "group cursor-default" : ""}
      `}
    >
      <img
        src={icon}
        className="w-5 h-5 object-contain"
      />

      <span className="text-zinc-300">
        {value}
      </span>

      {enableTooltip && tooltip && (
        <div
          className="
            absolute bottom-full mb-2
            left-1/2 -translate-x-1/2
            hidden group-hover:block
            bg-black text-white text-xs
            px-3 py-1 rounded
            shadow-lg z-50
            whitespace-nowrap
          "
        >
          {tooltip}
        </div>
      )}
    </div>
  )
}

function GetSpoilageLabel(spoilage: number) {
  if (spoilage == null) return `${t("spoilagetime.never")}`

  const entries = Object.entries(PERISH_MAP) as [keyof typeof PERISH_MAP, number][]
  entries.sort((a, b) => a[1] - b[1])

  for (const [key, value] of entries) {
    if (spoilage <= value) return SPOILAGE_LABELS[key]
  }

  return SPOILAGE_LABELS.PERISH_SUPERSLOW
}

function FormatTemperature(temperature: number, temperatureDuration: number) {
  if (temperature == null || temperatureDuration == null) return ""
  
  const sign = temperature > 0 ? "+" : temperature < 0 ? "-" : "0"

  const tempValue = 15
  const seconds = temperatureDuration 

  let timeString = ""
  if (seconds <= 60) {
    timeString = `${seconds} ${t("time.seconds")}`
  } else if (seconds < 480) {
    timeString = `${seconds / 60} ${t("time.minutes")}`
  } else {
    timeString = `${t("time.oneday")}`
  }

  return `${sign}${tempValue} for ${timeString}`
}

function FormatCookTime(cooktime: number) {
  if (!cooktime) return `0 ${t("time.seconds")}`

  const seconds = Math.round(cooktime * 10)

  if (seconds < 60) {
    const label = seconds === 1 ? t("time.second") : t("time.seconds")
    return `${seconds} ${label}`
  } else {
    const minutes = Math.round(seconds / 60)
    const label = minutes === 1 ? t("time.minute") : t("time.minutes")
    return `${minutes} ${label}`
  }
}

function FilterGroup({ title, children }: any) {
  return (
    <div className="flex flex-col gap-2">
      <span className="text-sm font-semibold text-zinc-400 mb-1">
        {title}
      </span>
      {children}
    </div>
  )
}

function CheckboxFilter({ label, checked, onChange }: any) {
  return (
    <label className="flex items-center gap-3 cursor-pointer text-sm text-zinc-300 hover:text-white transition-colors">
      <div
        className={`
          w-4 h-4
          border-2
          rounded
          flex items-center justify-center
          transition-all duration-150
          ${checked
            ? "bg-gray-500 border-gray-500"
            : "border-zinc-500 bg-zinc-500"
          }
        `}
      >
        {checked && (
          <span className="text-white text-xs font-bold">
            ✔
          </span>
        )}
      </div>

      <input
        type="checkbox"
        checked={checked}
        onChange={onChange}
        className="hidden"
      />

      {label}
    </label>
  )
}