"use client";

import { useState, useMemo, useRef, useEffect } from "react";
import { useTranslation } from "@/lib/i18n";
import { getAssetPath } from "@/lib/paths";
import { usePageTitle } from "@/components/PageTitle";
import recipes from "@/data/recipes_cookpot_keg.json";
import { recommendRecipe } from "@/lib/recommend";
import SeeAlso from "@/components/SeeAlso";
import AnimatedOverlay from "@/components/AnimatedOverlay";
import SkeletonImage from "@/components/SkeletonImage";
import Fuse from "fuse.js";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faMagnifyingGlass,
  faFilter,
  faFilterCircleXmark,
  faArrowDownAZ,
  faCircleChevronUp,
  faCircleChevronDown,
  faCircleChevronLeft,
  faCircleChevronRight,
  faArrowRightFromBracket,
  faCircleMinus,
  faCircleQuestion,
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

const FOODTYPE_ORDER = [
  "VEGGIE",
  "GOODIES",
  "MONSTER",
  "SOUL",
  "ALCOHOLIC",
  "ALCOHOLICMONSTER",
];

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

  example?: string[];
  excluded?: string[];

  required?: { ingredient: string; count: number }[];
  nameRequirement?: { ingredient: string; count: number }[];
  nameEqualsRequirement?: { ingredient: string; count: number }[];
  tagCountRequirement?: { tag: string; count: number }[];
  tagRequirement?: string[];
}

type IngredientBlock = {
  ingredient: string[];
  count?: number;
  comparator?: "lessthan" | "morethan" | "equal";
};

type RawIngredient = {
  items: string[];
  amount?: number;
  comparator?: "lessthan" | "morethan" | "equal";
};

type BlockProps = {
  children: React.ReactNode;
  showInfo?: boolean;
  infoText?: React.ReactNode;
  infoLink?: string;
};

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

export default function CookPotKeg() {
  const { t } = useTranslation();

  usePageTitle(t("pages.cookpot_keg.title")); 

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

    // 24 cooktime = 1 day
    const days = cooktime / 24;

    if (days >= 1) {
      const roundedDays = Math.round(days);
      const label = roundedDays === 1 ? t("time.day") : t("time.days");
      return `${roundedDays} ${label}`;
    }

    const seconds = Math.round(cooktime * 10);

    if (seconds < 60) {
      const label = seconds === 1 ? t("time.second") : t("time.seconds");
      return `${seconds} ${label}`;
    }

    const minutes = Math.round(seconds / 60);
    const label = minutes === 1 ? t("time.minute") : t("time.minutes");

    return `${minutes} ${label}`;
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
  const [filterCharacterFood, setFilterCharacterFood] = useState<boolean | null>(null);
  const [filterFoodType, setFilterFoodType] = useState<string[]>([]);

  const [search, setSearch] = useState("");
  const [searchOpen, setSearchOpen] = useState(false);
  const [highlightIndex, setHighlightIndex] = useState(0);

  const inputRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);
  const controlsRef = useRef<HTMLDivElement>(null);
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
    if (filterCharacterFood === true) {
      if (!recipe.characterfood) return false;
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
          valA = t(`recipes_keg.${a.name}`) ?? "";
          valB = t(`recipes_keg.${b.name}`) ?? "";
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

  const recipesWithLabel = useMemo(() => {
    return sortedRecipes.map((r) => ({
      ...r,
      label: t(`recipes_keg.${r.name}`),
    }));
  }, [sortedRecipes, t]);
  
  // FUZZY SEARCH
  const fuse = useMemo(() => {
    return new Fuse(recipesWithLabel, {
      keys: ["label"],
      threshold: 0.4,
      ignoreLocation: true,
    });
  }, [recipesWithLabel]);

  // SEARCHED RECIPES
  const searchedRecipes = useMemo(() => {
    if (!search.trim()) return [];

    return fuse
      .search(search)
      .slice(0, 8)
      .map((result) => result.item);
  }, [search, fuse]);

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

  useEffect(() => {
    if (!filtersOpen && !sortingOpen) return;

    function handleClickOutside(e: MouseEvent) {
      if (
        controlsRef.current &&
        !controlsRef.current.contains(e.target as Node)
      ) {
        setFiltersOpen(false);
        setSortingOpen(false);
      }
    }

    function handleKeyDown(e: KeyboardEvent) {
      if (e.key === "Escape") {
        setFiltersOpen(false);
        setSortingOpen(false);
      }
    }

    document.addEventListener("mousedown", handleClickOutside);
    document.addEventListener("keydown", handleKeyDown);

    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
      document.removeEventListener("keydown", handleKeyDown);
    };
  }, [filtersOpen, sortingOpen]);

  useEffect(() => {
    function handleKeyDown(e: KeyboardEvent) {
      if (e.key === "Escape") {
        setSelected(null);
      }
    }

    if (selected) {
      document.addEventListener("keydown", handleKeyDown);
    }

    return () => {
      document.removeEventListener("keydown", handleKeyDown);
    };
  }, [selected]);

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

  const selectedIndex = useMemo(() => {
    if (!selected) return -1;
    return sortedRecipes.findIndex(r => r.name === selected.name);
  }, [selected, sortedRecipes]);

  const goNext = () => {
    if (selectedIndex < sortedRecipes.length - 1) {
      setSelected(sortedRecipes[selectedIndex + 1]);
    }
  };

  const goPrev = () => {
    if (selectedIndex > 0) {
      setSelected(sortedRecipes[selectedIndex - 1]);
    }
  };

  useEffect(() => {
    function handleKeyDown(e: KeyboardEvent) {
      if (e.key === "Escape") setSelected(null);
      if (e.key === "ArrowRight") goNext();
      if (e.key === "ArrowLeft") goPrev();
    }

    if (selected) {
      document.addEventListener("keydown", handleKeyDown);
    }

    return () => {
      document.removeEventListener("keydown", handleKeyDown);
    };
  }, [selected, selectedIndex]);

  // Open recipe from URL param on initial load
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const name = params.get("recipe");
    if (name) {
      const recipe = sortedRecipes.find(r => r.name === name);
      if (recipe) {
        setSelected(recipe);
        const element = document.getElementById(`recipe-${recipe.name}`);
        if (element) {
          element.scrollIntoView({ behavior: "smooth", block: "center" });
        }
      }
    }
  }, [sortedRecipes.length]);

  // Keep URL in sync with selected recipe
  useEffect(() => {
    const url = new URL(window.location.href);
    if (selected) {
      url.searchParams.set("recipe", selected.name);
    } else {
      url.searchParams.delete("recipe");
    }
    window.history.replaceState({}, "", url.toString());
  }, [selected]);

  return (
    <div className="bg-zinc-300 dark:bg-zinc-800 text-zinc-900 dark:text-white min-h-screen">
      <div className="max-w-full pt-14"></div>
      {/* STICKY SEARCH + FILTER + SORT + BACK TO TOP */}
      <div className="sticky top-14 z-40 bg-zinc-300 dark:bg-zinc-800 shadow-md">
        <div className="max-w-4xl mx-auto px-1 pt-0 pb-1 sm:px-2 sm:py-2 flex flex-col sm:flex-row items-center justify-center gap-3">
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
                <div className="max-h-80 overflow-y-auto overscroll-contain hide-scrollbar">
                  {searchedRecipes.length === 0 && (
                    <div className="px-4 py-3 text-sm text-zinc-500 dark:text-white italic">
                      {t("search.notfound.recipe")}
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
                        src={getAssetPath(`/foods_cookpot_keg/${recipe.name}.png`)}
                        className="w-10 h-10 object-contain"
                      />
                      <span className="text-sm font-semibold">
                        {t(`recipes_keg.${recipe.name}`)}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
          <div
            ref={controlsRef}
            className="flex items-center justify-center gap-3 select-none relative"
          >
            {/* FILTER BUTTON */}
            <div className="relative group">
              <button
                onClick={() => setFiltersOpen(!filtersOpen)}
                className="bg-white dark:bg-zinc-900 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
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
                className="bg-white dark:bg-zinc-900 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
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
                  className="bg-white dark:bg-zinc-900 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
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
                  <div className="w-11/12 sm:w-[300px] bg-white dark:bg-zinc-900 border border-zinc-300 dark:border-zinc-700 rounded-xl p-4 flex flex-col gap-4 font-bold shadow-sm dark:shadow-none">
                    <DropdownGroup
                      title={t("filters.temperature")}
                      icon={getAssetPath("/icons/cooking/icon_temperature.png")}
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
                      icon={getAssetPath("/icons/cooking/icon_foodtype.png")}
                    >
                      {FOODTYPE_ORDER.filter((type) =>
                        recipes.some((r: any) => r.foodtype === type)
                        ).map((type) => (
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
                      icon={getAssetPath("/icons/cooking/icon_debuff.png")}
                    >
                      <CheckboxFilter
                        label={t("filters.debuff.hasdebuff")}
                        checked={filterDebuff === true}
                        onChange={() =>
                          setFilterDebuff(filterDebuff === true ? null : true)
                        }
                      />
                      <CheckboxFilter
                        label={t("filters.debuff.characterfood")}
                        checked={filterCharacterFood === true}
                        onChange={() =>
                          setFilterCharacterFood(filterCharacterFood === true ? null : true)
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
                  <div className="w-11/12 sm:w-[300px] bg-white dark:bg-zinc-900 border border-zinc-300 dark:border-zinc-700 rounded-xl p-4 flex flex-col gap-4 font-bold shadow-sm dark:shadow-none">
                    <DropdownGroup
                      title={t("sorting.directiontype")}
                      icon={getAssetPath("/icons/cooking/icon_priority.png")}
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
                      icon={getAssetPath("/icons/cooking/icon_debuff.png")}
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
      <div className="flex flex-wrap justify-center gap-3 sm:gap-5 font-bold m-6 select-none relative">
        {sortedRecipes.length === 0 && (
          <div className="w-full flex flex-col items-center justify-center text-center py-40">
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
            className="bg-white dark:bg-zinc-900 rounded-2xl p-3 flex flex-col items-center gap-3 cursor-pointer hover:scale-105 transition shadow-sm dark:shadow-none w-full sm:w-64"
          >
            <SkeletonImage
              src={getAssetPath(`/foods_cookpot_keg/${recipe.name}.png`)}
              className="w-24 h-24"
            />
            <h2 className="text-center font-semibold text-lg text-zinc-900 dark:text-white">
              {t(`recipes_keg.${recipe.name}`)}
            </h2>

            <div className="flex items-center gap-2 flex-wrap justify-center">
              {recipe.foodtype && <FoodType type={recipe.foodtype} t={t} />}
              {recipe.temperature != null && (
                <TopEffect
                  icon={getAssetPath("/icons/cooking/icon_temperature.png")}
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
                  icon={getAssetPath("/icons/cooking/icon_debuff.png")}
                  value={t("card.debuff.hasEffect")}
                  tooltip={t("tooltips.debuff")}
                />
              )}
              {recipe.characterfood &&
                (Array.isArray(recipe.characterfood)
                  ? recipe.characterfood
                  : [recipe.characterfood]
                ).map((char) => (
                  <TopEffect
                    key={char}
                    icon={getAssetPath(`/icons/characters/character_${char}.png`)}
                    value={t(`characterfood.${char}`)}
                    tooltip={t("tooltips.characterfood")}
                  />
                ))}
            </div>
          </div>
        ))}
      </div>
      {/* SELECTED CARD */}
      <AnimatedOverlay isOpen={!!selected} onClose={() => setSelected(null)}>
        {selected && (<>
          {/* PREVIOUS */}
          {selectedIndex > 0 && (
            <button
              onClick={(e) => {
                e.stopPropagation();
                goPrev();
              }}
              className="absolute left-2 sm:left-6 text-3xl sm:text-5xl text-white hover:text-white/80 dark:text-white/70 dark:hover:text-white/90 transition cursor-pointer z-10 drop-shadow"
            >
              <FontAwesomeIcon icon={faCircleChevronLeft} />
            </button>
          )}
          <div
            className="recipe-popup-panel bg-white dark:bg-zinc-900 rounded-2xl p-4 sm:p-8 w-11/12 md:w-[750px] max-h-[90vh] overflow-y-auto hide-scrollbar relative shadow-xl dark:shadow-none"
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

            <SkeletonImage
              src={getAssetPath(`/foods_cookpot_keg/${selected.name}.png`)}
              className="w-24 h-24 mx-auto mb-4"
            />

            <h2 className="text-center text-2xl font-semibold">
              {t(`recipes_keg.${selected.name}`)}
            </h2>

            <div className="flex justify-center my-4">
              <div className="w-full h-1 bg-zinc-200 dark:bg-zinc-700" />
            </div>
            <Block
              showInfo={true}
              infoText={
                <>
                  <div className="font-bold mb-1">
                    {t("card.ingredients.info.state_title")}
                  </div>

                  <p className="mb-2">{t("card.ingredients.info.state_p1")}</p>

                  <p className="mb-2">{t("card.ingredients.info.state_p2")}</p>

                  <p className="mb-3">{t("card.ingredients.info.state_p3")}</p>

                  <div className="font-bold mb-1">
                    {t("card.ingredients.info.excluded_title")}
                  </div>

                  <p className="mb-2">
                    {t("card.ingredients.info.excluded_p1")}
                  </p>

                  <p className="mb-2">
                    {t("card.ingredients.info.excluded_p2")}
                  </p>

                  <p>{t("card.ingredients.info.excluded_p3")}</p>
                </>
              }
              infoLink="https://dontstarve.wiki.gg/wiki/Crock_Pot/Recipe_Table"
            >
              <IngredientsTable recipe={selected} />
            </Block>
            <div className="flex justify-center my-3">
              <div className="w-full h-1 bg-zinc-200 dark:bg-zinc-700" />
            </div>
            {/* FOODTYPE + EFFECTS */}
            <div className="flex justify-center items-center gap-4 mb-3 mt-2 flex-wrap font-semibold">
              {selected.foodtype && <FoodType type={selected.foodtype} t={t} />}

              {selected.temperature != null && (
                <TopEffect
                  icon={getAssetPath("/icons/cooking/icon_temperature.png")}
                  value={FormatTemperature(
                    selected.temperature,
                    selected.temperatureDuration,
                  )}
                  tooltip={t("tooltips.temperature")}
                />
              )}

              {selected.debuff && (
                <TopEffect
                  icon={getAssetPath("/icons/cooking/icon_debuff.png")}
                  value={t(`recipes_debuff.${selected.name}`)}
                  tooltip={t("tooltips.debuff")}
                />
              )}
            </div>

            {/* STATUS */}
            <Block>
              <Stat
                icon={getAssetPath("/icons/cooking/icon_health.png")}
                value={selected.health}
                tooltip={t("tooltips.health")}
                isStatus
                recipe={selected}
                stat="health"
              />
              <Stat
                icon={getAssetPath("/icons/cooking/icon_hunger.png")}
                value={selected.hunger}
                tooltip={t("tooltips.hunger")}
                isStatus
                recipe={selected}
                stat="hunger"
              />
              <Stat
                icon={getAssetPath("/icons/cooking/icon_sanity.png")}
                value={selected.sanity}
                tooltip={t("tooltips.sanity")}
                isStatus
                recipe={selected}
                stat="sanity"
              />
            </Block>

            <Block>
              <Stat
                icon={getAssetPath("/icons/cooking/icon_priority.png")}
                value={selected.priority}
                tooltip={t("tooltips.priority")}
              />
              <Stat
                icon={getAssetPath("/icons/cooking/icon_cooktime.png")}
                value={FormatCookTime(selected.cooktime)}
                tooltip={t("tooltips.cooktime")}
              />
              <Stat
                icon={getAssetPath("/icons/cooking/icon_spoilage.png")}
                value={GetSpoilageLabel(selected.spoilage)}
                tooltip={t("tooltips.spoilage")}
              />
              {selected.stacksize && (
                <Stat
                  icon={getAssetPath("/icons/cooking/icon_stacksize.png")}
                  value={selected.stacksize}
                  tooltip={t("tooltips.stacksize")}
                />
              )}
            </Block>
            {(() => {
              const suggestion = recommendRecipe(selected, recipes);
              return suggestion ? (
                <SeeAlso
                  suggested={suggestion}
                  imageBasePath="/foods_cookpot_keg"
                  translationPrefix="recipes_keg"
                  onSelect={(recipe) => {
                    setSelected(null);
                    selectRecipe(recipe);
                  }}
                />
              ) : null;
            })()}
          </div>
          {/* NEXT */}
          {selectedIndex < sortedRecipes.length - 1 && (
            <button
              onClick={(e) => {
                e.stopPropagation();
                goNext();
              }}
              className="absolute right-2 sm:right-6 text-3xl sm:text-5xl text-white hover:text-white/80 dark:text-white/70 dark:hover:text-white/90 transition cursor-pointer z-10 drop-shadow"
            >
              <FontAwesomeIcon icon={faCircleChevronRight} />
            </button>
          )}
        </>)}
      </AnimatedOverlay>
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

function Block({ children, showInfo = false, infoText, infoLink }: BlockProps) {
  const { t } = useTranslation();
  const [open, setOpen] = useState(false);
  const boxRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (boxRef.current && !boxRef.current.contains(event.target as Node)) {
        setOpen(false);
      }
    }

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

  return (
    <div className="relative bg-zinc-100 dark:bg-zinc-800 rounded-xl p-4 flex flex-wrap gap-x-2 gap-y-2 justify-center items-center mb-5 min-h-[70px] shadow-sm dark:shadow-none">
      {showInfo && (
        <div ref={boxRef} className="absolute top-1 right-2">
          <button
            onClick={() => setOpen(!open)}
            className="cursor-pointer opacity-70 hover:opacity-100 scale-120"
          >
            <FontAwesomeIcon icon={faCircleQuestion} className="text-[14px]" />
          </button>

          {open && (
            <div className="absolute top-full right-0 mt-2 w-72 max-w-[calc(100vw-2rem)] break-words bg-black text-white dark:bg-white dark:text-black text-[12px] px-4 py-3 rounded shadow z-30 text-left leading-relaxed">
              {infoText}

              {infoLink && (
                <div className="mt-3 text-center">
                  <a
                    href={infoLink}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="underline text-blue-400 hover:text-blue-300 font-semibold"
                  >
                    {t("card.ingredients.info.learn_more")}
                  </a>
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {children}
    </div>
  );
}

function Stat({ icon, value, tooltip, isStatus = false, recipe, stat }: any) {
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

  const extrasMap: Record<number, string[]> = {};

  if (stat === "hunger" && recipe?.characterfood) {
    const charValue = (recipe.hunger ?? 0) + 15;
    extrasMap[charValue] ??= [];
    extrasMap[charValue].push(recipe.characterfood);
  }

  if (recipe?.monsterfood) {
    const monsterValue = recipe[`monster${stat}`] ?? 0;

    if (monsterValue !== 0) {
      extrasMap[monsterValue] ??= [];
      extrasMap[monsterValue].push("webber", "wortox");
    }
  }

  if (recipe?.mermfood) {
    const mermValue = recipe[`merm${stat}`] ?? 0;

    if (mermValue !== 0) {
      extrasMap[mermValue] ??= [];
      extrasMap[mermValue].push("wurt");
    }
  }

  const extraValues = Object.entries(extrasMap).map(([value, chars]) => ({
    value: Number(value),
    characters: [...new Set(chars)],
  }));

  return (
    <div className="relative group flex items-center gap-3 min-w-[120px] justify-center">
      <img src={icon} className="w-9 h-9 object-contain" />

      <div className="flex flex-col items-center leading-tight">
  <span className={`text-base font-semibold ${colorClass}`}>
    {displayValue}
  </span>

  {extraValues.map((extra, i) => (
    <span
      key={i}
      className=" font-semibold flex items-center gap-1 text-zinc-600 dark:text-zinc-400"
    >
      (
      <span className="text-green-500 font-semibold">
        {extra.value > 0 ? `+${extra.value}` : extra.value}
      </span>

      {extra.characters.map((char, index) => (
        <span key={char} className="flex items-center font-bold">
          <img
            src={getAssetPath(`/icons/characters/character_${char}.png`)}
            className="w-7 h-7"
          />
          {index < extra.characters.length - 1 && ""}
        </span>
      ))}
      )
    </span>
  ))}
</div>

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
        src={getAssetPath("/icons/cooking/icon_foodtype.png")}
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
            whitespace-nowrap max-w-xs sm:max-w-md md:max-w-lg
          "
        >
          {tooltip}
        </div>
      )}
    </div>
  );
}

function normalizeIngredientName(name: string) {
  if (name.startsWith("tag_")) return name;
  if (name.startsWith("kyno_")) return "ingredient_" + name.slice(5);
  if (name.startsWith("OR:")) {
    const clean = name.slice(3);
    return clean.startsWith("tag_") ? clean : "ingredient_" + clean;
  }
  return "ingredient_" + name;
}

function normalizeIngredients(
  items?: { items: string[]; amount?: number }[],
): { ingredient: string; count: number }[] {
  if (!items) return [];
  const result: { ingredient: string; count: number }[] = [];

  for (const entry of items) {
    const count = entry.amount ?? 1;
    if (entry.items.length > 1) {
      for (const name of entry.items) {
        result.push({ ingredient: "OR:" + name, count });
      }
    } else {
      result.push({ ingredient: entry.items[0], count });
    }
  }

  return result;
}

function normalizeIngredientsForDisplay(
  items?: { items: string[]; amount?: number }[],
) {
  if (!items) return [];
  return items.map((entry) => ({
    items: entry.items,
    amount: entry.amount ?? 1,
  }));
}

function IngredientIconWithCount({
  name,
  count = 1,
  comparator = "equal",
  t,
}: {
  name: string;
  count?: number;
  comparator?: "lessthan" | "morethan" | "equal";
  t: (key: string) => string;
}) {
  const iconName = normalizeIngredientName(name);

  function formatCount(n: number) {
    return Number.isInteger(n) ? n.toFixed(1) : n.toString();
  }

  const value = formatCount(count);

  let label = "";
  if (comparator === "lessthan") label = `<${value}`;
  if (comparator === "morethan") label = `${value}+`;
  if (comparator === "equal" && count > 1) label = `${count}x`;

  return (
    <div className="flex flex-col items-center font-bold group relative">
      <div className="w-10 h-10 relative">
        <img
          src={getAssetPath(`/icons/ingredients/${iconName}.png`)}
          className="w-full h-full object-contain"
        />

        <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-1 hidden group-hover:block bg-black text-white dark:bg-white dark:text-black text-[12px] px-2 py-1 rounded whitespace-nowrap shadow z-20">
          {getIngredientLabel(name, t)}
        </div>
      </div>

      <div className="mt-[2px] h-[1px] flex items-center justify-center">
        {label && (
          <div className="bg-black text-white text-[9px] px-1 py-[1px] rounded leading-none">
            {label}
          </div>
        )}
      </div>
    </div>
  );
}

function getIngredientLabel(name: string, t: (key: string) => string) {
  const clean = name
    .replace(/^kyno_/, "")
    .replace(/^tag_/, "")
    .replace(/^OR:/, "");

  if (name.startsWith("tag_")) {
    return t(`ingredients_tags.${clean}`) || clean;
  }

  return t(`ingredients.${clean}`) || clean;
}

function groupIngredients(items?: IngredientBlock[]) {
  if (!items) return [];

  const map: Record<string, number> = {};

  for (const item of items) {
    if (typeof item === "string") {
      map[item] = (map[item] || 0) + 1;
    } else {
      const key = item.ingredient.join(",");
      map[key] = (map[key] || 0) + (item.count ?? 1);
    }
  }

  return Object.entries(map).map(([ingredient, count]) => ({
    ingredient: ingredient.split(","),
    count,
  }));
}

function IngredientList({
  items,
  t,
}: {
  items?: IngredientBlock[];
  t: (key: string) => string;
}) {
  if (!items) return null;

  return (
    <div className="flex flex-wrap items-center gap-1 justify-center">
      {items.map((block, idx) => {
        const count = block.count ?? 1;
        const comparator = block.comparator ?? "equal";

        if (block.ingredient.length === 1) {
          return (
            <IngredientIconWithCount
              key={idx}
              name={block.ingredient[0]}
              count={count}
              comparator={comparator}
              t={t}
            />
          );
        } else {
          const main = block.ingredient[0];

          return (
            <div key={idx} className="flex items-center gap-1 text-[10px]">
              <span className="font-bold">(</span>

              {block.ingredient.map((item, i) => (
                <div key={i} className="flex items-center gap-1">
                  <IngredientIconWithCount
                    name={item}
                    count={count}
                    comparator={comparator}
                    t={t}
                  />

                  {i < block.ingredient.length - 1 && (
                    <span className="font-bold">{t("card.alternative")}</span>
                  )}
                </div>
              ))}

              <span className="font-bold">)</span>
            </div>
          );
        }
      })}
    </div>
  );
}

function IngredientsTable({ recipe }: { recipe: Recipe }) {
  const { t } = useTranslation();

  const required: IngredientBlock[] = (recipe as any).requires.map(
    (i: RawIngredient) => ({
      ingredient: i.items,
      count: i.amount,
      comparator: i.comparator ?? "equal",
    }),
  );

  const excluded: IngredientBlock[] = (recipe as any).excluded.map(
    (i: RawIngredient) => ({
      ingredient: i.items,
      count: i.amount,
      comparator: i.comparator ?? "equal",
    }),
  );

  const example: IngredientBlock[] = (recipe as any).card_def.map(
    (i: RawIngredient) => ({
      ingredient: i.items,
      count: i.amount,
      comparator: i.comparator ?? "equal",
    }),
  );

  return (
    <div className="flex flex-wrap gap-2 mt-1 text-center justify-center">
      <div className="min-w-[180px] max-w-[220px] flex-1">
        <div className="text-sm font-bold mb-2">
          {t("card.ingredients.required")}
        </div>
        <IngredientList items={required} t={t} />
      </div>

      <div className="min-w-[180px] max-w-[220px] flex-1">
        <div className="text-sm font-bold mb-2">
          {t("card.ingredients.excluded")}
        </div>
        {excluded.length > 0 ? (
          <IngredientList items={excluded} t={t} />
        ) : (
          <div className="opacity-70">
            <FontAwesomeIcon icon={faCircleMinus} className="scale-170 p-2" />
          </div>
        )}
      </div>

      <div className="min-w-[180px] max-w-[220px] flex-1">
        <div className="text-sm font-bold mb-2">
          {t("card.ingredients.example")}
        </div>
        <IngredientList items={example} t={t} />
      </div>
    </div>
  );
}
