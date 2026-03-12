"use client";

import { useState, useMemo, useRef, useEffect } from "react";
import { useTranslation } from "@/lib/i18n";
import { usePageTitle } from "@/components/PageTitle";
import { useSearchParams } from "next/navigation";
import { useRouter } from "next/navigation";
import ingredients from "@/data/ingredients.json";
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
} from "@fortawesome/free-solid-svg-icons";

const PERISH_MAP = {
  PERISH_ONEDAY: 480,
  PERISH_TWODAY: 960,
  PERISH_FOURDAY: 1920,
  PERISH_SUPERFAST: 1440,
  PERISH_MEDFAST: 2400,
  PERISH_FAST: 2880,
  PERISH_FASTISH: 3840,
  PERISH_MED: 4800,
  PERISH_SLOW: 7200,
  PERISH_PRESERVED: 9600,
  PERISH_SUPERSLOW: 19200,
};

interface SortOptionProps {
  value: string;
  label: string;
  current: string;
  onChange: (val: string) => void;
}

interface Ingredient {
  name: string;
  health?: number;
  hunger?: number;
  sanity?: number;
  spoilage?: number;
  foodtype?: string;
  cooktype?: string | string[];
  stacksize?: number;
  cooked?: boolean;
  dried?: boolean;
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

export default function Ingredients() {
  const { t } = useTranslation();

  usePageTitle(t("pages.ingredients.title")); 

  const SPOILAGE_LABELS = useMemo(
    () => ({
      PERISH_ONEDAY: t("spoilagetime.oneday"),
      PERISH_TWODAY: t("spoilagetime.twoday"),
      PERISH_FOURDAY: t("spoilagetime.fourday"),
      PERISH_SUPERFAST: t("spoilagetime.superfast"),
      PERISH_MEDFAST: t("spoilagetime.medfast"),
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

  const getVariantValue = (value: any, index: number) => {
    if (Array.isArray(value)) return value[index];
    return index === 0 ? value : undefined;
  };

  const [selected, setSelected] = useState<any>(null);

  const [showTopButton, setShowTopButton] = useState(false);

  const [filtersOpen, setFiltersOpen] = useState(false);
  const [sortingOpen, setSortingOpen] = useState(false);

  const [sortType, setSortType] = useState("default");
  const [sortDirection, setSortDirection] = useState<"asc" | "desc">("asc");

  const [filterFoodType, setFilterFoodType] = useState<string[]>([]);
  const [filterCookType, setFilterCookType] = useState<string[]>([]);

  const [search, setSearch] = useState("");
  const [searchOpen, setSearchOpen] = useState(false);
  const [highlightIndex, setHighlightIndex] = useState(0);

  const inputRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);
  const controlsRef = useRef<HTMLDivElement>(null);
  const bothOpen = filtersOpen && sortingOpen;

  // FILTERED INGREDIENTS
  const filteredIngredients = ingredients.filter((ingredient: any) => {
    if (filterFoodType.length > 0) {
      if (!ingredient.foodtype || !filterFoodType.includes(ingredient.foodtype))
        return false;
    }

    if (filterCookType.length > 0) {
      const cooktypes = Array.isArray(ingredient.cooktype)
        ? ingredient.cooktype
        : [ingredient.cooktype];

      if (!cooktypes.some((type: string) => filterCookType.includes(type)))
        return false;
    }

    return true;
  });

  const uniqueFoodTypes = useMemo<string[]>(() => {
    return [
      ...new Set(ingredients.map((i: any) => i.foodtype).filter(Boolean)),
    ].sort();
  }, []);

  const uniqueCookTypes = useMemo<string[]>(() => {
    return [
      ...new Set(
        ingredients
          .map((i: any) =>
            Array.isArray(i.cooktype) ? i.cooktype : [i.cooktype],
          )
          .flat()
          .filter(Boolean),
      ),
    ].sort();
  }, []);

  // SORTED INGREDIENTS
  const invertOrderFor = ["health", "hunger", "sanity"];
  const sortedIngredients = useMemo(() => {
    let arr = [...filteredIngredients];
    if (sortType === "default") return arr;
    const isInverted = invertOrderFor.includes(sortType);
    const directionMultiplier =
      sortDirection === "asc" ? (isInverted ? -1 : 1) : isInverted ? 1 : -1;
    arr.sort((a: any, b: any) => {
      let valA: any;
      let valB: any;
      switch (sortType) {
        case "alphabet":
          valA = t(`ingredients.${a.name}`) ?? "";
          valB = t(`ingredients.${b.name}`) ?? "";
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
  }, [filteredIngredients, sortType, sortDirection, t]);

  const expandedIngredients = useMemo(() => {
    return sortedIngredients.flatMap((ingredient: any) => {
      const list = [
        {
          ...ingredient,
          variant: "normal",
          label: t(`ingredients.${ingredient.name}`),
        },
      ];

      if (ingredient.cooked) {
        list.push({
          ...ingredient,
          variant: "cooked",
          label: t(`ingredients.${ingredient.name}_cooked`),
        });
      }

      if (ingredient.dried) {
        list.push({
          ...ingredient,
          variant: "dried",
          label: t(`ingredients.${ingredient.name}_dried`),
        });
      }

      return list;
    });
  }, [sortedIngredients, t]);

  // FUZZY SEARCH
  const fuse = useMemo(() => {
    return new Fuse(expandedIngredients, {
      keys: ["label"],
      threshold: 0.4,
      ignoreLocation: true,
    });
  }, [expandedIngredients]);

  // SEARCHED INGREDIENTS
  const searchedIngredients = useMemo(() => {
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
  const scrollToCard = (ingredientName: string) => {
    const element = document.getElementById(`ingredient-${ingredientName}`);
    if (element)
      element.scrollIntoView({ behavior: "smooth", block: "center" });
  };

  const selectIngredient = (ingredient: any) => {
    setSearch("");
    setSearchOpen(false);
    setHighlightIndex(0);
    scrollToCard(ingredient.name);
    setTimeout(() => setSelected(ingredient), 300);
  };

  const selectedIndex = useMemo(() => {
    if (!selected) return -1;
    return sortedIngredients.findIndex(r => r.name === selected.name);
  }, [selected, sortedIngredients]);

  const goNext = () => {
    if (selectedIndex < sortedIngredients.length - 1) {
      setSelected(sortedIngredients[selectedIndex + 1]);
    }
  };

  const goPrev = () => {
    if (selectedIndex > 0) {
      setSelected(sortedIngredients[selectedIndex - 1]);
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

  const searchParams = useSearchParams();
  const ingredientParam = searchParams.get("ingredient");
  
  useEffect(() => {
    if (ingredientParam) {
      const ingredient = sortedIngredients.find(r => r.name === ingredientParam);
      if (ingredient) {
        setSelected(ingredient);
        const element = document.getElementById(`ingredient-${ingredient.name}`);
        if (element) {
          element.scrollIntoView({ behavior: "smooth", block: "center" });
        }
      }
    }
  }, [ingredientParam, sortedIngredients]);

  const router = useRouter();

  useEffect(() => {
    if (ingredientParam) {
      const ingredient = sortedIngredients.find(r => r.name === ingredientParam);
      if (ingredient) {
        setSelected(ingredient);
        const element = document.getElementById(`ingredient-${ingredient.name}`);
        if (element) {
          element.scrollIntoView({ behavior: "smooth", block: "center" });
        }
      }
      router.replace("/ingredients", { scroll: false });
    }
  }, [ingredientParam, sortedIngredients]);

  return (
    <div className="bg-zinc-300 dark:bg-zinc-800 text-zinc-900 dark:text-white min-h-screen">
      <div className="max-w-full pt-14"></div>
      {/* STICKY SEARCH + FILTER + SORT + BACK TO TOP */}
      <div className="sticky top-14 z-40 bg-zinc-300 dark:bg-zinc-800 shadow-md">
        <div className="max-w-4xl mx-auto p-2 flex flex-row items-center justify-center gap-3">
          {/* SEARCH - Agora alinhado horizontalmente */}
          <div className="relative w-full max-w-sm">
            <div className="absolute inset-y-0 left-3 flex items-center pointer-events-none text-zinc-500 dark:text-white">
              <FontAwesomeIcon icon={faMagnifyingGlass} />
            </div>
            <input
              ref={inputRef}
              type="text"
              placeholder={t("search.title.ingredient")}
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
                if (!searchedIngredients.length) return;
                if (e.key === "ArrowDown") {
                  e.preventDefault();
                  setHighlightIndex((prev) =>
                    prev < searchedIngredients.length - 1 ? prev + 1 : 0,
                  );
                }
                if (e.key === "ArrowUp") {
                  e.preventDefault();
                  setHighlightIndex((prev) =>
                    prev > 0 ? prev - 1 : searchedIngredients.length - 1,
                  );
                }
                if (e.key === "Enter") {
                  e.preventDefault();
                  selectIngredient(searchedIngredients[highlightIndex]);
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
                  {searchedIngredients.length === 0 && (
                    <div className="px-4 py-3 text-sm text-zinc-500 dark:text-white italic">
                      {t("search.notfound.ingredient")}
                    </div>
                  )}
                  {searchedIngredients.map((ingredient, idx) => (
                    <div
                      key={`${ingredient.name}-${ingredient.variant}`}
                      onClick={() => selectIngredient(ingredient)}
                      className={`flex items-center gap-3 px-4 py-3 cursor-pointer transition ${
                        highlightIndex === idx
                          ? "bg-zinc-100 dark:bg-zinc-800"
                          : "hover:bg-zinc-100 dark:hover:bg-zinc-800"
                      }`}
                    >
                      <img
                        src={`/icons/ingredients/ingredient_${ingredient.name}${ingredient.variant === "normal" ? "" : `_${ingredient.variant}`}.png`}
                        className="w-10 h-10 object-contain"
                      />
                      <span className="text-sm font-semibold">
                        {ingredient.label}
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
                className="bg-zinc-100 dark:bg-zinc-900 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
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
                className="bg-zinc-100 dark:bg-zinc-900 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
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
                  className="bg-zinc-100 dark:bg-zinc-900 hover:bg-zinc-200 dark:hover:bg-zinc-700 px-4 py-3 rounded-xl font-bold flex items-center gap-2 cursor-pointer"
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
                  <div className="w-[700px] max-h-[420px] bg-white dark:bg-zinc-900 border border-zinc-300 dark:border-zinc-700 rounded-xl overflow-hidden shadow-sm dark:shadow-none">
                    <div className="max-h-[420px] overflow-y-auto overscroll-contain p-4 flex flex-col gap-2 font-bold">
                      <DropdownGroup
                        title={t("filters.foodtype")}
                        icon="/icons/cooking/icon_foodtype.png"
                      >
                        <div className="grid grid-cols-[max-content_max-content] gap-x-9 gap-y-2">
                          {uniqueFoodTypes.map((type: string) => (
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
                        </div>
                        <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20 my-1" />
                      </DropdownGroup>
                      <DropdownGroup
                        title={t("filters.cooktype")}
                        icon="/icons/cooking/icon_cooktype.png"
                      >
                        <div className="grid grid-cols-5 gap-x-0 gap-y-2">
                          {uniqueCookTypes.map((value: string) => (
                            <CheckboxFilter
                              key={value}
                              label={t(`cooktypes.${value}`)}
                              checked={filterCookType.includes(value)}
                              onChange={() =>
                                setFilterCookType((prev) =>
                                  prev.includes(value)
                                    ? prev.filter((v) => v !== value)
                                    : [...prev, value],
                                )
                              }
                            />
                          ))}
                        </div>
                        <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20 my-1" />
                      </DropdownGroup>

                      <button
                        onClick={() => {
                          setFilterFoodType([]);
                          setFilterCookType([]);
                        }}
                        className="bg-zinc-300 dark:bg-zinc-500 hover:bg-red-700 rounded-lg py-2 text-sm font-bold cursor-pointer"
                      >
                        {t("filters.clear")}
                      </button>
                    </div>
                  </div>
                )}

                {/* SORT PANEL */}
                {sortingOpen && (
                  <div className="w-[300px] bg-white dark:bg-zinc-900 border border-zinc-300 dark:border-zinc-700 rounded-xl p-4 flex flex-col gap-3 font-bold shadow-sm dark:shadow-none">
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
                      {/*
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
                        label={t("sorting.type.spoilage")}
                        checked={sortType === "spoilage"}
                        onChange={() => setSortType("spoilage")}
                      />
                      */}
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
      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-5 font-bold m-6 select-none relative">
        {sortedIngredients.length === 0 && (
          <div className="col-span-full flex flex-col items-center justify-center text-center py-40">
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
                setFilterFoodType([]);
                setFilterCookType([]);
              }}
              className="mt-4 px-4 py-2 bg-zinc-500 dark:bg-zinc-700 rounded-lg hover:bg-zinc-400 dark:hover:bg-zinc-600 text-white"
            >
              {t("filters.clear")}
            </button>
          </div>
        )}
        {sortedIngredients.map((ingredient, index) => (
          <div
            key={ingredient.name}
            id={`ingredient-${ingredient.name}`}
            onClick={() => setSelected(ingredient)}
            className="bg-white dark:bg-zinc-900 rounded-2xl p-3 flex flex-col items-center gap-3 cursor-pointer hover:scale-105 transition shadow-sm dark:shadow-none"
          >
            <img
              src={`/icons/ingredients/ingredient_${ingredient.name}.png`}
              className="w-15"
            />
            <h2 className="text-center font-semibold text-lg text-zinc-900 dark:text-white">
              {t(`ingredients.${ingredient.name}`)}
            </h2>

            <div className="flex items-center gap-2 flex-wrap justify-center">
              {ingredient.foodtype && (
                <FoodType type={ingredient.foodtype} t={t} />
              )}
              {ingredient.cooktype && (
                <CookType types={ingredient.cooktype} t={t} />
              )}
            </div>
          </div>
        ))}
      </div>
      {/* SELECTED CARD */}
      {selected &&
        (() => {
          const variants = [
            { type: "normal", enabled: true, label: t("card.values.raw") },
            {
              type: "cooked",
              enabled: selected.cooked,
              label: t("card.values.cooked"),
            },
            {
              type: "dried",
              enabled: selected.dried,
              label: t("card.values.dried"),
            },
          ].filter((v) => v.enabled);

          return (
            <div
              className="fixed inset-0 bg-black/70 flex items-center justify-center z-50"
              onClick={() => setSelected(null)}
            >
              <div className="flex items-center gap-6">
                {/* PREVIOUS */}
                {selectedIndex > 0 && (
                  <div
                    className="p-8 flex items-center justify-center"
                    onClick={(e) => e.stopPropagation()}
                  >
                    <div className="relative group">
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          goPrev();
                        }}
                        className="text-5xl text-white hover:text-white/80 dark:text-white/70 dark:hover:text-white/90 transition cursor-pointer"
                      >
                        <FontAwesomeIcon icon={faCircleChevronLeft} />
                      </button>
                      <div
                        className="
                        absolute bottom-full mb-2
                        left-1/2 -translate-x-1/2
                        hidden group-hover:block
                        bg-black text-white dark:bg-white dark:text-black
                        text-xs font-semibold
                        px-3 py-1 rounded
                        whitespace-nowrap
                        shadow-lg
                        "
                      >
                        {t("main.previous")}
                      </div>
                    </div>
                  </div>
                )}
              </div>
              <div
                className="bg-white dark:bg-zinc-900 rounded-2xl p-8 w-[750px] relative shadow-xl dark:shadow-none scale-95"
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

                {/* INGREDIENT IMAGES */}
                <div className="flex justify-center items-center gap-6 mb-4">
                  {variants.map((variant, i) => (
                    <div
                      key={variant.type}
                      className="flex flex-col items-center"
                    >
                      <img
                        src={`/icons/ingredients/ingredient_${selected.name}${variant.type === "normal" ? "" : `_${variant.type}`}.png`}
                        className="w-20 h-20 object-contain"
                      />
                      <span className="text-sm font-semibold text-zinc-900 dark:text-white mt-1 text-center">
                        {variant.type === "normal"
                          ? t(`ingredients.${selected.name}`)
                          : t(`ingredients.${selected.name}_${variant.type}`)}
                      </span>
                    </div>
                  ))}
                </div>

                <div className="flex justify-center my-4">
                  <div className="w-200 h-1 bg-zinc-200 dark:bg-zinc-700" />
                </div>

                {/* FOODTYPE + EFFECTS */}
                <div className="flex justify-center items-center gap-4 mb-6 mt-2 flex-wrap font-semibold">
                  {selected.foodtype && (
                    <FoodType type={selected.foodtype} t={t} />
                  )}
                  {selected.cooktype && (
                    <CookType
                      types={selected.cooktype}
                      values={selected.cookvalue}
                      t={t}
                    />
                  )}
                </div>
                {/* STATUS */}
                {variants.map((variant, i) => (
                  <div
                    key={variant.type}
                    className="flex flex-col items-center w-full"
                  >
                    {/* TITLE */}
                    <span className="text-sm font-bold text-zinc-700 dark:text-zinc-300 mb-2">
                      {variant.label}
                    </span>

                    <Block>
                      <Stat
                        icon="/icons/cooking/icon_health.png"
                        value={getVariantValue(selected.health, i)}
                        tooltip={t("tooltips.health")}
                        isStatus
                      />

                      <Stat
                        icon="/icons/cooking/icon_hunger.png"
                        value={getVariantValue(selected.hunger, i)}
                        tooltip={t("tooltips.hunger")}
                        isStatus
                      />

                      <Stat
                        icon="/icons/cooking/icon_sanity.png"
                        value={getVariantValue(selected.sanity, i)}
                        tooltip={t("tooltips.sanity")}
                        isStatus
                      />

                      <Stat
                        icon="/icons/cooking/icon_spoilage.png"
                        value={GetSpoilageLabel(
                          getVariantValue(selected.spoilage, i),
                        )}
                        tooltip={t("tooltips.spoilage")}
                      />
                    </Block>
                  </div>
                ))}
              </div>
              {/* NEXT */}
              {selectedIndex < sortedIngredients.length - 1 && (
                <div
                  className="p-8 flex items-center justify-center"
                  onClick={(e) => e.stopPropagation()}
                >
                  <div className="relative group">
                    <button
                      onClick={(e) => {
                        e.stopPropagation();
                        goNext();
                      }}
                      className="text-5xl text-white hover:text-white/80 dark:text-white/70 dark:hover:text-white/90 transition cursor-pointer"
                    >
                      <FontAwesomeIcon icon={faCircleChevronRight} />
                    </button>
                    <div
                      className="
                      absolute bottom-full mb-2
                      left-1/2 -translate-x-1/2
                      hidden group-hover:block
                      bg-black text-white dark:bg-white dark:text-black
                      text-xs font-semibold
                      px-3 py-1 rounded
                      whitespace-nowrap
                      shadow-lg
                      "
                    >
                      {t("main.next")}
                    </div>
                  </div>
                </div>
              )}
            </div>
          );
        })()}
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

function CookType({
  types,
  values,
  t,
}: {
  types: string | string[];
  values?: number[];
  t: (key: string) => string;
}) {
  const list = Array.isArray(types) ? types : [types];

  return (
    <div className="relative group flex items-center gap-2 bg-zinc-100 dark:bg-zinc-800 px-3 py-1 rounded-full text-xs tracking-wide cursor-default">
      <img
        src="/icons/cooking/icon_cooktype.png"
        className="w-5 h-5 object-contain"
      />

      <span className="text-zinc-900 dark:text-white">
        {list
          .map((type, i) => {
            const value = values?.[i];
            const label = t(`cooktypes.${type}`);
            return value !== undefined ? `${value} ${label}` : label;
          })
          .join("  —  ")}
      </span>

      <div className="absolute bottom-full mb-2 left-1/2 -translate-x-1/2 hidden group-hover:block bg-black text-white dark:bg-white dark:text-black text-xs px-3 py-1 rounded whitespace-nowrap shadow-lg z-50 pointer-events-none">
        {t("tooltips.cooktype")}
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
