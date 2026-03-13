"use client";

import { useState, useMemo, useEffect, useRef } from "react";
import { useTranslation } from "@/lib/i18n";
import { usePageTitle } from "@/components/PageTitle";
import { useRouter } from "next/navigation";
import RandomRecipe from "../components/RandomRecipe";
import DailyRecipe from "../components/DailyRecipe";

import recipes from "@/data/recipes_cookpot.json";
import recipes_warly from "@/data/recipes_cookpot_warly.json";
import recipes_seasonal from "@/data/recipes_cookpot_seasonal.json";
import recipes_jar from "@/data/recipes_cookpot_jar.json";
import recipes_keg from "@/data/recipes_cookpot_keg.json";
import ingredients from "@/data/ingredients.json";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faMagnifyingGlass,
  faCircleQuestion,
  faGear,
  faUsers,
} from "@fortawesome/free-solid-svg-icons";
import { faDiscord, faSteam, faKoFi } from "@fortawesome/free-brands-svg-icons";

import Link from "next/link";
import Fuse from "fuse.js";

export default function HomePage() {
  const { t } = useTranslation();
  const router = useRouter();

  usePageTitle(t("pages.home.title"));

  const [search, setSearch] = useState("");
  const [searchOpen, setSearchOpen] = useState(false);
  const [highlightIndex, setHighlightIndex] = useState(0);
  const inputRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);

  const selectItem = (item: any) => {
    setSearch("");
    setSearchOpen(false);
    setHighlightIndex(0);

    const currentPath = window.location.pathname;

    if (item.type === "ingredients") {
      const query = item.name;

      if (currentPath !== "/ingredients") {
        router.push(`/ingredients?ingredient=${query}`);
      } else {
        const element = document.getElementById(`ingredient-${query}`);
        if (element) {
          element.scrollIntoView({ behavior: "smooth", block: "center" });
        }
      }
    } else {
      const recipePageMap: Record<string, string> = {
        recipes: "/recipes_cookpot",
        recipes_warly: "/recipes_warly",
        recipes_keg: "/recipes_keg",
        recipes_jar: "/recipes_jar",
        recipes_seasonal: "/recipes_seasonal",
      };

      const page = recipePageMap[item.type] || "/recipes_cookpot";

      if (currentPath !== page) {
        router.push(`${page}?recipe=${item.name}`);
      } else {
        const element = document.getElementById(`recipe-${item.name}`);
        if (element) {
          element.scrollIntoView({ behavior: "smooth", block: "center" });
        }
      }
    }
  };

  const expandedIngredients = useMemo(() => {
    return ingredients.flatMap((ingredient: any) => {
      const list = [
        {
          ...ingredient,
          type: "ingredients",
          icon: "/icons/misc/icon_ingredients.png",
          variant: "normal",
          label: t(`ingredients.${ingredient.name}`),
        },
      ];
      if (ingredient.cooked) {
        list.push({
          ...ingredient,
          type: "ingredients",
          icon: "/icons/misc/icon_ingredients.png",
          variant: "cooked",
          label: t(`ingredients.${ingredient.name}_cooked`),
        });
      }
      if (ingredient.dried) {
        list.push({
          ...ingredient,
          type: "ingredients",
          icon: "/icons/misc/icon_ingredients.png",
          variant: "dried",
          label: t(`ingredients.${ingredient.name}_dried`),
        });
      }
      return list;
    });
  }, [ingredients, t]);

  const allItems = useMemo(() => {
    const mapRecipes = (list: any[], type: string, iconPath: string) =>
      list.map((item) => ({
        ...item,
        type,
        icon: iconPath,
        label: t(`${type}.${item.name}`) || item.name,
      }));

    const recipeItems = [
      ...mapRecipes(recipes, "recipes", "/foods_cookpot"),
      ...mapRecipes(recipes_warly, "recipes_warly", "/foods_cookpot_warly"),
      ...mapRecipes(recipes_keg, "recipes_keg", "/foods_cookpot_keg"),
      ...mapRecipes(recipes_jar, "recipes_jar", "/foods_cookpot_jar"),
      ...mapRecipes(recipes_seasonal, "recipes_seasonal", "/foods_seasonal"),
    ];

    return [...recipeItems, ...expandedIngredients];
  }, [t, expandedIngredients]);

  const fuse = useMemo(() => {
    return new Fuse(allItems, {
      keys: ["label"],
      threshold: 0.4,
      ignoreLocation: true,
    });
  }, [allItems]);

  const searchedItems = useMemo(() => {
    if (!search.trim()) return [];
    return fuse
      .search(search)
      .slice(0, 8)
      .map((r) => r.item);
  }, [search, fuse]);

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

  return (
    <div className="min-h-screen bg-zinc-300 dark:bg-zinc-800 text-zinc-900 dark:text-white flex justify-center relative">
      {/* SETTINGS BUTTON */}
      <div className="fixed top-4 right-4 z-50">
        <Link href="/settings">
          <button className="flex items-center gap-2 px-3 py-3 rounded-xl bg-zinc-100 dark:bg-zinc-900 hover:bg-zinc-400 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <FontAwesomeIcon icon={faGear} className="w-6 h-6" />
          </button>
        </Link>
      </div>

      {/* MAIN CONTAINER */}
      <div className="w-full max-w-5xl flex flex-col items-center px-4 sm:px-6">
        {/* TITLE */}
        <div className="mt-10 mb-5 flex flex-col items-center text-center">
          <div className="flex items-center gap-4">
            <img
              src="/icons/misc/icon_hof.png"
              className="w-20 h-20 sm:w-[120px] sm:h-[120px] drop-shadow-lg"
            />
            <div className="flex flex-col items-center text-center drop-shadow-md">
              <h1 className="text-xl sm:text-2xl md:text-3xl font-bold">{t("main.title")}</h1>
              <p className="text-sm sm:text-base md:text-lg text-zinc-700 dark:text-zinc-400">
                {t("main.subtitle")}
              </p>
            </div>
          </div>
        </div>
        {/* SEARCH */}
        <div className="w-full max-w-150 mb-4 flex gap-2 sm:gap-3">
          {/* INPUT */}
          <div className="relative flex-1">
            <div className="absolute inset-y-0 left-3 flex items-center pointer-events-none text-zinc-500 dark:text-white">
              <FontAwesomeIcon icon={faMagnifyingGlass} />
            </div>
            <input
              ref={inputRef}
              type="text"
              placeholder={t("search.title.everything")}
              value={search}
              onChange={(e) => {
                setSearch(e.target.value);
                setSearchOpen(true);
                setHighlightIndex(0);
              }}
              onFocus={() => setSearchOpen(true)}
              onKeyDown={(e) => {
                if (!searchedItems.length) return;
                if (e.key === "ArrowDown") {
                  e.preventDefault();
                  setHighlightIndex((prev) =>
                    prev < searchedItems.length - 1 ? prev + 1 : 0,
                  );
                }
                if (e.key === "ArrowUp") {
                  e.preventDefault();
                  setHighlightIndex((prev) =>
                    prev > 0 ? prev - 1 : searchedItems.length - 1,
                  );
                }
                if (e.key === "Enter") {
                  e.preventDefault();
                  selectItem(searchedItems[highlightIndex]);
                }
                if (e.key === "Escape") {
                  setSearch("");
                  setSearchOpen(false);
                  setHighlightIndex(0);
                  inputRef.current?.blur();
                  return;
                }
              }}
              className="w-full bg-white dark:bg-zinc-900 rounded-xl px-10 py-3 text-lg italic shadow focus:outline-none"
            />
            {searchOpen && search && (
              <div
                ref={dropdownRef}
                className="absolute top-full mt-2 w-full bg-white dark:bg-zinc-900 rounded-xl shadow-xl overflow-hidden z-50"
              >
                <div className="max-h-100 overflow-y-auto overscroll-contain">
                  {searchedItems.length === 0 && (
                    <div className="px-4 py-3 text-sm text-zinc-500 dark:text-white italic">
                      {t("search.notfound.everything")}
                    </div>
                  )}
                  {searchedItems.map((item, idx) => (
                    <div
                      key={`${item.name}-${item.variant || "none"}`}
                      onClick={() => selectItem(item)}
                      className={`flex items-center gap-3 px-4 py-3 cursor-pointer transition ${
                        highlightIndex === idx
                          ? "bg-zinc-100 dark:bg-zinc-700"
                          : "hover:bg-zinc-100 dark:hover:bg-zinc-700"
                      }`}
                    >
                      <img
                        src={
                          item.type === "ingredients"
                            ? `/icons/ingredients/ingredient_${item.name}${
                                item.variant === "normal"
                                  ? ""
                                  : `_${item.variant}`
                              }.png`
                            : item.type === "recipes_seasonal"
                              ? `/foods_cookpot_seasonal/${item.name}.png`
                              : `${item.icon}/${item.name}.png`
                        }
                        className="w-10 h-10 object-contain"
                      />
                      <span className="text-sm font-semibold">
                        {item.label}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* RANDOM RECIPE BUTTON */}
          <RandomRecipe onSelectItem={selectItem} interval={500} />
        </div>

        {/* SEARCH CATEGORY TEXT */}
        <div className="mb-6 text-center w-full">
          <h2 className="text-xl font-bold tracking-wide text-zinc-900 dark:text-white">
            {t("main.browsecategory")}
          </h2>
        </div>

        {/* CATEGORIES */}
        <div className="grid grid-cols-2 sm:grid-cols-3 xl:grid-cols-6 gap-4 sm:gap-20 mb-6 w-full justify-items-center drop-shadow-md">
          <CategoryCard
            icon="/icons/misc/icon_cookpot.png"
            label={t("main.cookpot")}
            href="/recipes_cookpot"
          />
          <CategoryCard
            icon="/icons/misc/icon_cookpot_warly.png"
            label={t("main.cookpot_warly")}
            href="/recipes_warly"
          />
          <CategoryCard
            icon="/icons/misc/icon_cookpot_keg.png"
            label={t("main.cookpot_keg")}
            href="/recipes_keg"
          />
          <CategoryCard
            icon="/icons/misc/icon_cookpot_jar.png"
            label={t("main.cookpot_jar")}
            href="/recipes_jar"
          />
          <CategoryCard
            icon="/icons/misc/icon_cookpot_seasonal.png"
            label={t("main.cookpot_seasonal")}
            href="/recipes_seasonal"
          />
          <CategoryCard
            icon="/icons/misc/icon_ingredients.png"
            label={t("main.ingredients")}
            href="/ingredients"
          />
        </div>

        <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20" />

        {/* DAILY RECIPE */}
        <div className="flex justify-center items-center px-4 pt-2 pb-5 w-full">
          <DailyRecipe />
        </div>

        <div className="w-full h-1 bg-zinc-700/20 dark:bg-white/20" />

        {/* EXTERNAL LINKS */}
        <div className="flex flex-wrap justify-center m-6 gap-6 mb-10 w-full">
          <ExternalButton
            icon={faSteam}
            label={t("footer.download")}
            href="https://steamcommunity.com/sharedfiles/filedetails/?id=2334209327"
          />
          <ExternalButton
            icon={faDiscord}
            label={t("footer.discord")}
            href="https://discord.gg/jjNr4Vvutn"
          />
          <LocalButton
            icon={faUsers}
            label={t("footer.contributors")}
            href="/contributors"
          />
          <ExternalButton
            icon={faKoFi}
            label={t("footer.kofi")}
            href="https://ko-fi.com/kynoox"
          />
        </div>
      </div>
    </div>
  );
}

function CategoryCard({ icon, label, href }: any) {
  return (
    <a
      href={href}
      className="
        w-40 h-40
        bg-white dark:bg-zinc-900
        rounded-2xl
        flex flex-col
        items-center
        justify-center
        gap-4
        font-semibold
        text-lg
        text-center
        hover:scale-105
        transition
        shadow-sm
        dark:shadow-none
      "
    >
      <img src={icon} className="w-16 h-16 object-contain" />

      <span>{label}</span>
    </a>
  );
}

function ExternalButton({ icon, label, href }: any) {
  return (
    <a
      href={href}
      target="_blank"
      className="
      bg-zinc-100 dark:bg-zinc-900
      px-6 py-4
      rounded-xl
      flex items-center gap-3
      font-bold
      text-lg
      hover:scale-105
      transition
      shadow
      "
    >
      <FontAwesomeIcon icon={icon} />
      {label}
    </a>
  );
}

function LocalButton({ icon, label, href }: any) {
  return (
    <a
      href={href}
      className="
        bg-zinc-100 dark:bg-zinc-900
      px-6 py-4
      rounded-xl
      flex items-center gap-3
      font-bold
      text-lg
      hover:scale-105
      transition
      shadow
      "
    >
      <FontAwesomeIcon icon={icon} />
      {label}
    </a>
  );
}
