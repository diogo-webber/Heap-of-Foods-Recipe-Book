"use client"

import { useState } from "react"
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
  FOOD_TEMP_DURATION: 480,
}

export default function CookPot() {
  const [selected, setSelected] = useState<any>(null)

  return (
    <div className="bg-zinc-950 text-white min-h-screen p-10">
      <div className="flex flex-col items-center gap-3 mb-8">
        <div className="flex items-center gap-3">
          <img
            src="/icons/icon_cookpot.png"
            className="w-15 h-15 object-contain"
          />

          <h1 className="text-4xl font-bold text-white text-center">
            {t("title")}
          </h1>
        </div>
    </div>

      {/* GRID */}
      <div className="grid grid-cols-4 gap-8">
        {recipes.map((recipe, index) => (
          <div
            key={index}
            onClick={() => setSelected(recipe)}
            className="bg-zinc-900 rounded-2xl p-6 flex flex-col font-semibold items-center gap-4 cursor-pointer hover:scale-105 transition"
          >
            <img
              src={`/foods_cookpot/${recipe.name}.png`}
              alt={recipe.name}
              className="w-28"
            />

            <h2 className="text-center font-semibold text-lg">
              {t(`recipes.${recipe.name}`)}
            </h2>

            <div className="w-full h-0.5 bg-white/100 my1"></div>

            <div className="font-semibold flex items-center gap-2 flex-wrap justify-center">
              {recipe.foodtype && (
                <FoodType type={recipe.foodtype} />
              )}

              {recipe.temperature && (
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
                  value={selected.debuff}
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

/* BLOCO */
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

      {/* TEXTO TRADUZIDO */}
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