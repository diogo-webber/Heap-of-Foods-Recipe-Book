"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useTranslation } from "@/lib/i18n";

import recipes from "@/data/recipes_cookpot.json";
import recipes_warly from "@/data/recipes_cookpot_warly.json";
import recipes_keg from "@/data/recipes_cookpot_keg.json";
import recipes_jar from "@/data/recipes_cookpot_jar.json";
import recipes_seasonal from "@/data/recipes_cookpot_seasonal.json";

const recipePages = [
  "recipes_cookpot",
  "recipes_warly",
  "recipes_keg",
  "recipes_jar",
  "recipes_seasonal",
];

const allRecipeIcons = [
  ...recipes.map((r) => `/foods_cookpot/${r.name}.png`),
  ...recipes_warly.map((r) => `/foods_cookpot_warly/${r.name}.png`),
  ...recipes_keg.map((r) => `/foods_cookpot_keg/${r.name}.png`),
  ...recipes_jar.map((r) => `/foods_cookpot_jar/${r.name}.png`),
  ...recipes_seasonal.map((r) => `/foods_cookpot_seasonal/${r.name}.png`),
];

interface RandomRecipeButtonProps {
  interval?: number;
  onSelectItem?: (item: any) => void;
}

export default function RandomRecipe({interval = 500, onSelectItem, }: RandomRecipeButtonProps) {
  const { t } = useTranslation();

  const [iconIndex, setIconIndex] = useState(
    Math.floor(Math.random() * allRecipeIcons.length)
  );
  const [hovered, setHovered] = useState(false);

  useEffect(() => {
    if (!hovered) return;
    const timer = setInterval(() => {
      setIconIndex(Math.floor(Math.random() * allRecipeIcons.length));
    }, interval);
    return () => clearInterval(timer);
  }, [hovered, interval]);

  const goRandomRecipe = () => {
    if (!onSelectItem) return;

    const allRecipes = [
      ...recipes.map(r => ({ ...r, type: "recipes", icon: "/foods_cookpot" })),
      ...recipes_warly.map(r => ({ ...r, type: "recipes_warly", icon: "/foods_cookpot_warly" })),
      ...recipes_keg.map(r => ({ ...r, type: "recipes_keg", icon: "/foods_cookpot_keg" })),
      ...recipes_jar.map(r => ({ ...r, type: "recipes_jar", icon: "/foods_cookpot_jar" })),
      ...recipes_seasonal.map(r => ({ ...r, type: "recipes_seasonal", icon: "/foods_cookpot_seasonal" })),
    ];

    const randomItem = allRecipes[Math.floor(Math.random() * allRecipes.length)];

    onSelectItem(randomItem);
  };

  return (
    <button
      onClick={goRandomRecipe}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      className="
      flex items-center justify-center
      gap-2 px-2 sm:px-4 py-1.5 sm:py-2
      bg-white dark:bg-zinc-900
      rounded-xl
      shadow hover:shadow-lg
      font-semibold text-zinc-900 dark:text-white
      hover:scale-105 transition
      cursor-pointer
      "
    >
      <img
        src={allRecipeIcons[iconIndex]}
        className="w-8 h-8 sm:w-10 sm:h-10 object-contain transition-all duration-300"
      />
      <span className="leading-none">{t("main.randomrecipe")}</span>
    </button>
  );
}