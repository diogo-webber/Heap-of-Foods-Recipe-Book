"use client";

import { useState, useMemo, useRef, useEffect } from "react";
import { useTranslation } from "@/lib/i18n";
import recipes from "@/data/recipes_cookpot.json";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faMagnifyingGlass,
  faFilter,
  faFilterCircleXmark,
  faArrowDownAZ,
  faCircleChevronUp,
  faArrowRightFromBracket,
} from "@fortawesome/free-solid-svg-icons";

const PERISH_MAP = {
  PERISH_SUPERFAST: 1440,
  PERISH_FAST: 2880,
  PERISH_FASTISH: 3840,
  PERISH_MED: 4800,
  PERISH_SLOW: 7200,
  PERISH_PRESERVED: 9600,
  PERISH_SUPERSLOW: 19200,
};

const TEMPERATURE_DURATION_MAP = {
  FOOD_TEMP_BRIEF: 5,
  FOOD_TEMP_AVERAGE: 10,
  FOOD_TEMP_LONG: 15,
  FOOD_TEMP_DURATION: 480,
};

interface SortOptionProps {
  value: string;
  label: string;
  current: string;
  onChange: (val: string) => void;
}

interface Recipe {
  name: string;
  health?: number;
  hunger?: number;
  sanity?: number;
  priority?: number;
  cooktime?: number;
  spoilage?: number;
  temperature?: number;
  temperatureDuration?: number;
  debuff?: boolean;
  foodtype?: string;
  stacksize?: number;
}

const SortOption = ({ value, label, current, onChange }: SortOptionProps) => (
  <label className="flex items-center gap-3 cursor-pointer text-sm text-zinc-900 dark:text-white hover:text-zinc-700 dark:hover:text-white transition-colors">
    <div
      className={`w-5 h-5 border-2 rounded flex items-center justify-center transition ${
        current === value
          ? "bg-gray-500 border-gray-500"
          : "border-zinc-500 dark:border-zinc-400 bg-white dark:bg-zinc-900"
      }`}
    >
      {current === value && (
        <span className="text-zinc-900 dark:text-white text-sm font-black">
          ✔
        </span>
      )}
    </div>
    <input
      type="radio"
      className="hidden"
      checked={current === value}
      onChange={() => onChange(value)}
    />
    {label}
  </label>
);

export default function CookPot() {
  const { t } = useTranslation();

  const SPOILAGE_LABELS = useMemo(
    () => ({
      PERISH_SUPERFAST: t("spoilagetime.superfast"),
      PERISH_FAST: t("spoilagetime.fast"),
      PERISH_FASTISH: t("spoilagetime.fastish"),
      PERISH_MED: t("spoilagetime.med"),
      PERISH_SLOW: t("spoilagetime.slow"),
      PERISH_PRESERVED: t("spoilagetime.preserved"),
      PERISH_SUPERSLOW: t("spoilagetime.superslow"),
    }),
    [t],
  );

  const GetSpoilageLabel = (spoilage: number | undefined) => {
    if (spoilage == null) return t("spoilagetime.never");

    const entries = Object.entries(PERISH_MAP) as [
      keyof typeof PERISH_MAP,
      number,
    ][];
    entries.sort((a, b) => a[1] - b[1]);
    for (const [key, value] of entries) {
      if (spoilage <= value) return SPOILAGE_LABELS[key];
    }
    return SPOILAGE_LABELS.PERISH_SUPERSLOW;
  };

  const FormatCookTime = (cooktime: number | undefined) => {
    if (!cooktime) return `0 ${t("time.seconds")}`;
    const seconds = Math.round(cooktime * 10);
    if (seconds < 60) {
      const label = seconds === 1 ? t("time.second") : t("time.seconds");
      return `${seconds} ${label}`;
    } else {
      const minutes = Math.round(seconds / 60);
      const label = minutes === 1 ? t("time.minute") : t("time.minutes");
      return `${minutes} ${label}`;
    }
  };

  const FormatTemperature = (
    temperature: number,
    temperatureDuration: number,
  ) => {
    const sign = temperature > 0 ? "+" : temperature < 0 ? "-" : "0";
    const tempValue = 15;
    const seconds = temperatureDuration;
    let timeString = "";
    if (seconds <= 60) timeString = `${seconds} ${t("time.seconds")}`;
    else if (seconds < 480) timeString = `${seconds / 60} ${t("time.minutes")}`;
    else timeString = t("time.oneday");
    return `${sign}${tempValue} ${t("time.for")} ${timeString}`;
  };

  const [selected, setSelected] = useState<any>(null);

  const [showTopButton, setShowTopButton] = useState(false);

  const [filtersOpen, setFiltersOpen] = useState(false);
  const [sortingOpen, setSortingOpen] = useState(false);

  const [sortType, setSortType] = useState("default");
  const [sortDirection, setSortDirection] = useState<"asc" | "desc">("asc");

  const [filterTemp, setFilterTemp] = useState<string | null>(null);
  const [filterDebuff, setFilterDebuff] = useState<boolean | null>(null);
  const [filterFoodType, setFilterFoodType] = useState<string[]>([]);

  const [search, setSearch] = useState("");
  const [searchOpen, setSearchOpen] = useState(false);
  const [highlightIndex, setHighlightIndex] = useState(0);

  const inputRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);
  const bothOpen = filtersOpen && sortingOpen;

  // FILTERED RECIPES
  const filteredRecipes = recipes.filter((recipe: any) => {
    if (filterTemp !== null) {
      if (filterTemp === "hot" && recipe.temperature <= 0) return false;
      if (filterTemp === "cold" && recipe.temperature >= 0) return false;
      if (filterTemp === "none" && recipe.temperature !== null) return false;
    }
    if (filterDebuff !== null) {
      if (recipe.debuff !== filterDebuff) return false;
    }
    if (filterFoodType.length > 0) {
      if (!filterFoodType.includes(recipe.foodtype)) return false;
    }
    return true;
  });

  // SORTED RECIPES
  const invertOrderFor = ["health", "hunger", "sanity"];
  const sortedRecipes = useMemo(() => {
    let arr = [...filteredRecipes];
    if (sortType === "default") return arr;
    const isInverted = invertOrderFor.includes(sortType);
    const directionMultiplier =
      sortDirection === "asc" ? (isInverted ? -1 : 1) : isInverted ? 1 : -1;
    arr.sort((a: any, b: any) => {
      let valA: any;
      let valB: any;
      switch (sortType) {
        case "alphabet":
          valA = t(`recipes.${a.name}`) ?? "";
          valB = t(`recipes.${b.name}`) ?? "";
          return valA.localeCompare(valB) * directionMultiplier;
        case "spoilage":
          valA = a.spoilage ?? 0;
          valB = b.spoilage ?? 0;
          break;
        default:
          valA = a[sortType] ?? 0;
          valB = b[sortType] ?? 0;
          break;
      }
      return (valA - valB) * directionMultiplier;
    });
    return arr;
  }, [filteredRecipes, sortType, sortDirection, t]);

  // SEARCHED RECIPES
  const searchedRecipes = useMemo(() => {
    if (!search.trim()) return [];
    return sortedRecipes
      .filter((recipe: any) =>
        t(`recipes.${recipe.name}`)
          .toLowerCase()
          .includes(search.toLowerCase()),
      )
      .slice(0, 8);
  }, [search, sortedRecipes]);

  // OUTSIDE CLICK
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (
        dropdownRef.current &&
        !dropdownRef.current.contains(event.target as Node) &&
        !inputRef.current?.contains(event.target as Node)
      ) {
        setSearchOpen(false);
        setSearch("");
        setHighlightIndex(0);
      }
    }

    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  // HIDE BACK TO TOP BUTTON
  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 1000) {
        setShowTopButton(true);
      } else {
        setShowTopButton(false);
      }
    };

    window.addEventListener("scroll", handleScroll);

    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, []);

  // SCROLL TO CARD
  const scrollToCard = (recipeName: string) => {
    const element = document.getElementById(`recipe-${recipeName}`);
    if (element)
      element.scrollIntoView({ behavior: "smooth", block: "center" });
  };

  const selectRecipe = (recipe: any) => {
    setSearch("");
    setSearchOpen(false);
    setHighlightIndex(0);
    scrollToCard(recipe.name);
    setTimeout(() => setSelected(recipe), 300);
  };

  return (
    <div className="bg-zinc-300 dark:bg-zinc-950 text-zinc-900 dark:text-white min-h-screen">
      <div className="max-w-full pt-16 pb-1"></div>
      {/* STICKY SEARCH + FILTER + SORT + BACK TO TOP */}
      <div className="sticky top-14 z-40 bg-zinc-300 dark:bg-zinc-950 shadow-md">
        <div className="max-w-4xl mx-auto p-2 flex flex-row items-center justify-center gap-3">
          {/* SEARCH - Agora alinhado horizontalmente */}
          <div className="relative w-full max-w-sm">
            <div className="absolute inset-y-0 left-3 flex items-center pointer-events-none text-zinc-500 dark:text-white">
              <FontAwesomeIcon icon={faMagnifyingGlass} />
            </div>
            <input
              ref={inputRef}
              type="text"
              placeholder={t("search.title.recipe")}
              value={search}
              onChange={(e) => {
                setSearch(e.target.value);
                setSearchOpen(true);
                setHighlightIndex(0);
              }}
              onFocus={() => setSearchOpen(true)}
              onKeyDown={(e) => {
                if (e.key === "Escape") {
                  setSearch("");
                  setSearchOpen(false);
                  setHighlightIndex(0);
                  inputRef.current?.blur();
                  return;
                }
                if (!searchedRecipes.length) return;
                if (e.key === "ArrowDown") {
                  e.preventDefault();
                  setHighlightIndex((prev) =>
                    prev < searchedRecipes.length - 1 ? prev + 1 : 0,
                  );
                }
                if (e.key === "ArrowUp") {
                  e.preventDefault();
                  setHighlightIndex((prev) =>
                    prev > 0 ? prev - 1 : searchedRecipes.length - 1,
                  );
                }
                if (e.key === "Enter") {
                  e.preventDefault();
                  selectRecipe(searchedRecipes[highlightIndex]);
                }
              }}
              className="w-full bg-white dark:bg-zinc-900 rounded-xl px-10 py-2 text-zinc-900 dark:text-white italic focus:outline-none focus:border-zinc-300 dark:focus:border-zinc-700 transition"
            />
            {searchOpen && search && (
              <div
                ref={dropdownRef}
                className="absolute top-full mt-2 w-full bg-white dark:bg-zinc-900 rounded-xl shadow-xl overflow-hidden z-50"
              >
                <div className="max-h-80 overflow-y-auto overscroll-contain">
                  {searchedRecipes.length === 0 && (
                    <div className="px-4 py-3 text-sm text-zinc-500 dark:text-white italic">
                      {t("search.notfound")}
                    </div>
                  )}
                  {searchedRecipes.map((recipe, idx) => (
                    <div
                      key={recipe.name}
                      onClick={() => selectRecipe(recipe)}
                      className={`flex items-center gap-3 px-4 py-3 cursor-pointer transition ${
                        highlightIndex === idx
                          ? "bg-zinc-100 dark:bg-zinc-800"
                          : "hover:bg-zinc-100 dark:hover:bg-zinc-800"
                      }`}
                    >
                      <img
                        src={`/foods_cookpot/${recipe.name}.png`}
                        className="w-10 h-10 object-contain"
                      />
                      <span className="text-sm font-semibold">
                        {t(`recipes.${recipe.name}`)}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
          <div className="flex items-center justify-center gap-3 select-none relative">
            {/* FILTER BUTTON */}
            <div className="relative group">
              <button
                onClick={() => setFiltersOpen(!filtersOpen)}
                className="bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
              >
                <FontAwesomeIcon icon={faFilter} />
              </button>

              {!filtersOpen && (
                <div className="absolute top-9 mb-2 left-1/2 -translate-x-1/2 hidden group-hover:block bg-black text-white dark:bg-white dark:text-black text-xs font-semibold px-3 py-1 rounded whitespace-nowrap shadow-lg z-50 pointer-events-none">
                  {t("filters.title")}
                </div>
              )}
            </div>

            {/* SORT BUTTON */}
            <div className="relative group">
              <button
                onClick={() => setSortingOpen(!sortingOpen)}
                className="bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
              >
                <FontAwesomeIcon icon={faArrowDownAZ} />
              </button>

              {!sortingOpen && (
                <div className="absolute top-9 mb-2 left-1/2 -translate-x-1/2 hidden group-hover:block bg-black text-white dark:bg-white dark:text-black text-xs font-semibold px-3 py-1 rounded whitespace-nowrap shadow-lg z-50 pointer-events-none">
                  {t("sorting.title")}
                </div>
              )}
            </div>

            {/* BACK TO TOP */}
            <div className="relative group">
              {showTopButton && (
                <button
                  onClick={() =>
                    window.scrollTo({ top: 0, behavior: "smooth" })
                  }
                  className="bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
                >
                  <FontAwesomeIcon icon={faCircleChevronUp} />
                </button>
              )}

              <div className="absolute top-9 mb-2 left-1/2 -translate-x-1/2 hidden group-hover:block bg-black text-white dark:bg-white dark:text-black text-xs font-semibold px-3 py-1 rounded whitespace-nowrap shadow-lg z-50 pointer-events-none">
                {t("main.backtotop")}
              </div>
            </div>

            {/* DROPDOWN PANELS */}
            {(filtersOpen || sortingOpen) && (
              <div className="absolute top-full mt-3 left-1/2 -translate-x-1/2 flex items-start gap-4 z-50">
                {/* FILTER PANEL */}
                {filtersOpen && (
                  <div className="w-[300px] bg-white dark:bg-zinc-900 border border-zinc-300 dark:border-zinc-700 rounded-xl p-4 flex flex-col gap-4 font-bold shadow-sm dark:shadow-none">
                    <DropdownGroup
                      title={t("filters.temperature")}
                      icon="/icons/cooking/icon_temperature.png"
                    >
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
                      <CheckboxFilter
                        label={t("card.temperature.none")}
                        checked={filterTemp === "none"}
                        onChange={() =>
                          setFilterTemp(filterTemp === "none" ? null : "none")
                        }
                      />
                    </DropdownGroup>

                    <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20" />

                    <DropdownGroup
                      title={t("filters.foodtype")}
                      icon="/icons/cooking/icon_foodtype.png"
                    >
                      {[...new Set(recipes.map((r: any) => r.foodtype))]
                        .filter(Boolean)
                        .map((type) => (
                          <CheckboxFilter
                            key={type}
                            label={t(`foodtypes.${type}`)}
                            checked={filterFoodType.includes(type)}
                            onChange={() =>
                              setFilterFoodType((prev) =>
                                prev.includes(type)
                                  ? prev.filter((t) => t !== type)
                                  : [...prev, type],
                              )
                            }
                          />
                        ))}
                    </DropdownGroup>

                    <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20" />

                    <DropdownGroup
                      title={t("filters.debuff.title")}
                      icon="/icons/cooking/icon_debuff.png"
                    >
                      <CheckboxFilter
                        label={t("filters.debuff.hasdebuff")}
                        checked={filterDebuff === true}
                        onChange={() =>
                          setFilterDebuff(filterDebuff === true ? null : true)
                        }
                      />
                    </DropdownGroup>

                    <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20" />

                    <button
                      onClick={() => {
                        setFilterTemp(null);
                        setFilterFoodType([]);
                        setFilterDebuff(null);
                      }}
                      className="bg-zinc-300 dark:bg-zinc-500 hover:bg-red-700 rounded-lg py-2 text-sm font-bold cursor-pointer"
                    >
                      {t("filters.clear")}
                    </button>
                  </div>
                )}

                {/* SORT PANEL */}
                {sortingOpen && (
                  <div className="w-[300px] bg-white dark:bg-zinc-900 border border-zinc-300 dark:border-zinc-700 rounded-xl p-4 flex flex-col gap-4 font-bold shadow-sm dark:shadow-none">
                    <DropdownGroup
                      title={t("sorting.directiontype")}
                      icon="/icons/cooking/icon_priority.png"
                    >
                      <CheckboxFilter
                        label={t("sorting.direction.up")}
                        checked={sortDirection === "asc"}
                        onChange={() => setSortDirection("asc")}
                      />
                      <CheckboxFilter
                        label={t("sorting.direction.down")}
                        checked={sortDirection === "desc"}
                        onChange={() => setSortDirection("desc")}
                      />
                    </DropdownGroup>

                    <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20" />

                    <DropdownGroup
                      title={t("sorting.ordertype")}
                      icon="/icons/cooking/icon_debuff.png"
                    >
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
                    </DropdownGroup>

                    <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20" />

                    <button
                      onClick={() => {
                        setSortType("default");
                        setSortDirection("asc");
                      }}
                      className="bg-zinc-300 dark:bg-zinc-500 hover:bg-red-700 rounded-lg py-2 text-sm font-bold cursor-pointer"
                    >
                      {t("sorting.clear")}
                    </button>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </div>
      {/* CARD GRID */}
      <div className="grid grid-cols-4 gap-5 font-bold m-6 select-none relative">
        {sortedRecipes.length === 0 && (
          <div className="col-span-4 flex flex-col items-center justify-center text-center py-40">
            <FontAwesomeIcon
              icon={faFilterCircleXmark}
              className="text-7xl mb-4 text-zinc-700 dark:text-zinc-500 opacity-80"
            />
            <h2 className="text-xl font-semibold mt-4 text-zinc-900 dark:text-zinc-100">
              {t("filters.noresults")}
            </h2>
            <p className="text-sm text-zinc-700 dark:text-zinc-400 mt-2">
              {t("filters.trydifferent")}
            </p>
            <button
              onClick={() => {
                setFilterTemp(null);
                setFilterFoodType([]);
                setFilterDebuff(null);
              }}
              className="mt-4 px-4 py-2 bg-zinc-500 dark:bg-zinc-700 rounded-lg hover:bg-zinc-400 dark:hover:bg-zinc-600 text-white"
            >
              {t("filters.clear")}
            </button>
          </div>
        )}
        {sortedRecipes.map((recipe, index) => (
          <div
            key={index}
            id={`recipe-${recipe.name}`}
            onClick={() => setSelected(recipe)}
            className="bg-white dark:bg-zinc-900 rounded-2xl p-3 flex flex-col items-center gap-3 cursor-pointer hover:scale-105 transition shadow-sm dark:shadow-none"
          >
            <img src={`/foods_cookpot/${recipe.name}.png`} className="w-24" />
            <h2 className="text-center font-semibold text-lg text-zinc-900 dark:text-white">
              {t(`recipes.${recipe.name}`)}
            </h2>

            <div className="flex items-center gap-2 flex-wrap justify-center">
              {recipe.foodtype && <FoodType type={recipe.foodtype} t={t} />}
              {recipe.temperature != null && (
                <TopEffect
                  icon="/icons/cooking/icon_temperature.png"
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
                  icon="/icons/cooking/icon_debuff.png"
                  value={t("card.debuff.hasEffect")}
                  tooltip={t("tooltips.debuff")}
                />
              )}
            </div>
          </div>
        ))}
      </div>
      {/* SELECTED CARD */}
      {selected && (
        <div
          className="fixed inset-0 bg-black/70 flex items-center justify-center z-50"
          onClick={() => setSelected(null)}
        >
          <div
            className="bg-white dark:bg-zinc-900 rounded-2xl p-8 w-[750px] relative shadow-xl dark:shadow-none"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex justify-end">
              <button
                onClick={() => setSelected(null)}
                className="
                bg-zinc-100 dark:bg-zinc-800
                hover:bg-zinc-200 dark:hover:bg-zinc-700
                px-3 py-1
                rounded-lg
                font-bold
                text-zinc-900 dark:text-white
                transition-all
                duration-200
                flex items-center gap-2
                cursor-pointer
                "
              >
                <FontAwesomeIcon icon={faArrowRightFromBracket} />
                {t("main.close")}
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
              <div className="w-200 h-1 bg-zinc-200 dark:bg-zinc-700" />
            </div>

            {/* FOODTYPE + EFFECTS */}
            <div className="flex justify-center items-center gap-4 mb-6 mt-2 flex-wrap font-semibold">
              {selected.foodtype && <FoodType type={selected.foodtype} t={t} />}

              {selected.temperature != null && (
                <TopEffect
                  icon="/icons/cooking/icon_temperature.png"
                  value={FormatTemperature(
                    selected.temperature,
                    selected.temperatureDuration,
                  )}
                  tooltip={t("tooltips.temperature")}
                />
              )}

              {selected.debuff && (
                <TopEffect
                  icon="/icons/cooking/icon_debuff.png"
                  value={t(`recipes_debuff.${selected.name}`)}
                  tooltip={t("tooltips.debuff")}
                />
              )}
            </div>

            {/* STATUS */}
            <Block>
              <Stat
                icon="/icons/cooking/icon_health.png"
                value={selected.health}
                tooltip={t("tooltips.health")}
                isStatus
              />
              <Stat
                icon="/icons/cooking/icon_hunger.png"
                value={selected.hunger}
                tooltip={t("tooltips.hunger")}
                isStatus
              />
              <Stat
                icon="/icons/cooking/icon_sanity.png"
                value={selected.sanity}
                tooltip={t("tooltips.sanity")}
                isStatus
              />
            </Block>

            <Block>
              <Stat
                icon="/icons/cooking/icon_priority.png"
                value={selected.priority}
                tooltip={t("tooltips.priority")}
              />
              <Stat
                icon="/icons/cooking/icon_cooktime.png"
                value={FormatCookTime(selected.cooktime)}
                tooltip={t("tooltips.cooktime")}
              />
              <Stat
                icon="/icons/cooking/icon_spoilage.png"
                value={GetSpoilageLabel(selected.spoilage)}
                tooltip={t("tooltips.spoilage")}
              />
            </Block>

            {selected.stacksize && (
              <Block>
                <Stat
                  icon="/icons/cooking/icon_stacksize.png"
                  value={selected.stacksize}
                  tooltip={t("tooltips.stacksize")}
                />
              </Block>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

function FilterGroup({ title, children }: any) {
  return (
    <div className="flex flex-col gap-2">
      <span className="text-sm font-semibold text-zinc-900 dark:text-white mb-1">
        {title}
      </span>
      {children}
    </div>
  );
}

function CheckboxFilter({ label, checked, onChange }: any) {
  return (
    <label className="flex items-center gap-3 cursor-pointer text-sm text-zinc-900 dark:text-white hover:text-zinc-700 dark:hover:text-white transition-colors">
      <div
        className={`
          w-4 h-4
          border-2
          rounded
          flex items-center justify-center
          transition-all duration-150
          ${
            checked
              ? "bg-gray-500 border-gray-500"
              : "border-zinc-400 dark:border-zinc-500 bg-zinc-400 dark:bg-zinc-500"
          }
        `}
      >
        {checked && (
          <span className="text-zinc-900 dark:text-white text-xs font-bold">
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
  );
}

function DropdownGroup({ title, icon, children }: any) {
  return (
    <div className="flex flex-col gap-1">
      <div className="flex items-center gap-2 text-xs uppercase tracking-wider text-zinc-900 dark:text-white font-bold">
        <img src={icon} className="w-6 h-6" />
        {title}
      </div>

      <div className="flex flex-col gap-2 pl-1">{children}</div>
    </div>
  );
}

function Block({ children }: any) {
  return (
    <div className="bg-zinc-100 dark:bg-zinc-800 rounded-xl p-4 flex justify-evenly items-center mb-5 min-h-[70px] shadow-sm dark:shadow-none">
      {children}
    </div>
  );
}

function Stat({ icon, value, tooltip, isStatus = false }: any) {
  if (value === undefined || value === null) return null;

  let displayValue = value;
  let colorClass = "text-zinc-900 dark:text-white";

  if (isStatus) {
    const numericValue = Number(value);

    if (!isNaN(numericValue)) {
      if (numericValue > 0) {
        displayValue = `+${numericValue}`;
        colorClass = "text-green-500";
      } else if (numericValue < 0) {
        displayValue = `-${Math.abs(numericValue)}`;
        colorClass = "text-red-500";
      } else {
        displayValue = "0";
        colorClass = "text-zinc-900 dark:text-white";
      }
    }
  }

  return (
    <div className="relative group flex items-center gap-3 min-w-[120px] justify-center">
      <img src={icon} className="w-9 h-9 object-contain" />

      <span className={`text-base font-semibold ${colorClass}`}>
        {displayValue}
      </span>

      <div
        className="
        absolute bottom-full mb-2
        left-1/2 -translate-x-1/2
        hidden group-hover:block
        bg-black text-white dark:bg-white dark:text-black text-xs font-semibold
        px-3 py-1 rounded whitespace-nowrap
        shadow-lg z-50 pointer-events-none
      "
      >
        {tooltip}
      </div>
    </div>
  );
}

function FoodType({ type, t }: { type: string; t: (key: string) => string }) {
  return (
    <div className="relative group flex items-center gap-2 bg-zinc-100 dark:bg-zinc-800 px-3 py-1 rounded-full text-xs tracking-wide cursor-default">
      <img
        src="/icons/cooking/icon_foodtype.png"
        className="w-5 h-5 object-contain"
      />
      <span className="text-zinc-900 dark:text-white">
        {t(`foodtypes.${type}`)}
      </span>
      <div className="absolute bottom-full mb-2 left-1/2 -translate-x-1/2 hidden group-hover:block bg-black text-white dark:bg-white dark:text-black text-xs px-3 py-1 rounded whitespace-nowrap shadow-lg z-50 pointer-events-none">
        {t("tooltips.foodtype")}
      </div>
    </div>
  );
}

function TopEffect({ icon, value, tooltip, enableTooltip = true }: any) {
  return (
    <div
      className={`
        relative flex items-center gap-2
        bg-zinc-100 dark:bg-zinc-800
        px-3 py-1
        rounded-full
        text-xs tracking-wide
        ${enableTooltip && tooltip ? "group cursor-default" : ""}
      `}
    >
      <img src={icon} className="w-5 h-5 object-contain" />

      <span className="text-zinc-900 dark:text-white">{value}</span>

      {enableTooltip && tooltip && (
        <div
          className="
            absolute bottom-full mb-2
            left-1/2 -translate-x-1/2
            hidden group-hover:block
            bg-black text-white text-xs dark:bg-white dark:text-black
            px-3 py-1 rounded
            shadow-lg z-50
            whitespace-nowrap
          "
        >
          {tooltip}
        </div>
      )}
    </div>
  );
}
