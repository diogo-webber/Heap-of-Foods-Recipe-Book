"use client";

import React, { useState, useEffect } from "react";
import { useTranslation } from "@/lib/i18n";
import { getAssetPath } from "@/lib/paths";
import { useRouter, usePathname } from "next/navigation";

import recipes from "@/data/recipes_cookpot.json";
import recipes_warly from "@/data/recipes_cookpot_warly.json";
import recipes_seasonal from "@/data/recipes_cookpot_seasonal.json";
import recipes_jar from "@/data/recipes_cookpot_jar.json";
import recipes_keg from "@/data/recipes_cookpot_keg.json";

type SourceKeys = "cookpot" | "warly" | "keg" | "jar" | "seasonal";

interface RecipeType {
  name: string;
  health?: number;
  hunger?: number;
  sanity?: number;
  temperature?: number | null;
  temperatureDuration?: number | null;
  debuff?: boolean;
  foodtype?: string;

  prefix: string;
  icon: string;
  source: SourceKeys;
}

interface FoodTypeProps {
  type: string;
  t: (key: string) => string;
}

export default function DailyRecipe() {
  const { t } = useTranslation();
  const router = useRouter();
  const pathname = usePathname();

  const allRecipes = [
    ...recipes.map(r => ({ ...r, prefix: "recipes", icon: "foods_cookpot", source: "cookpot" })),
    ...recipes_warly.map(r => ({ ...r, prefix: "recipes_warly", icon: "foods_cookpot_warly", source: "warly" })),
    ...recipes_keg.map(r => ({ ...r, prefix: "recipes_keg", icon: "foods_cookpot_keg", source: "keg" })),
    ...recipes_jar.map(r => ({ ...r, prefix: "recipes_jar", icon: "foods_cookpot_jar", source: "jar" })),
    ...recipes_seasonal.map(r => ({ ...r, prefix: "recipes_seasonal", icon: "foods_cookpot_seasonal", source: "seasonal" })),
  ];

  const SOURCE_INFO: Record<SourceKeys, { icon: string; name: string; page: string }> = {
    cookpot: {
      icon: getAssetPath("/icons/misc/icon_cookpot.png"),
      name: t("main.cookpot"),
      page: "/recipes_cookpot",
    },
    warly: {
      icon: getAssetPath("/icons/misc/icon_cookpot_warly.png"),
      name: t("main.cookpot_warly"),
      page: "/recipes_warly",
    },
    keg: {
      icon: getAssetPath("/icons/misc/icon_cookpot_keg.png"),
      name: t("main.cookpot_keg"),
      page: "/recipes_keg",
    },
    jar: {
      icon: getAssetPath("/icons/misc/icon_cookpot_jar.png"),
      name: t("main.cookpot_jar"),
      page: "/recipes_jar",
    },
    seasonal: {
      icon: getAssetPath("/icons/misc/icon_cookpot_seasonal.png"),
      name: t("main.cookpot_seasonal"),
      page: "/recipes_seasonal",
    },
  } as const;

  const [now, setNow] = useState(Date.now());

  useEffect(() => {
    const interval = setInterval(() => setNow(Date.now()), 1000);
    return () => clearInterval(interval);
  }, []);

  function seededRandom(seed: number) {
    const x = Math.sin(seed) * 10000;
    return x - Math.floor(x);
  }

  const ROTATION_HOURS = 24; // 200 = 10 sec for easy test.
  const ROTATION_MS = ROTATION_HOURS * 60 * 60 * 1000;

  function getDailyRecipe() {
    const OFFSET_MS = 0;
    const seed = Math.floor((now + OFFSET_MS) / ROTATION_MS);
    const random = seededRandom(seed);
    const index = Math.floor(random * allRecipes.length);
    return allRecipes[index];
  }

  const recipe = getDailyRecipe();
  const source = SOURCE_INFO[recipe.source as SourceKeys];

  const timeLeftMs = ROTATION_MS - (now % ROTATION_MS);
  const hours = Math.floor(timeLeftMs / (1000 * 60 * 60));
  const minutes = Math.floor((timeLeftMs % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((timeLeftMs % (1000 * 60)) / 1000);
  const timerText = `${hours.toString().padStart(2,"0")}:${minutes.toString().padStart(2,"0")}:${seconds.toString().padStart(2,"0")}`;

  function formatTemperature(
    temperature: number,
    temperatureDuration: number | null,
  ) {
    if (temperature == null || temperatureDuration == null) return "";

    const sign = temperature > 0 ? "+" : temperature < 0 ? "-" : "";
    const tempValue = Math.abs(temperature);
    const seconds = temperatureDuration;

    let timeString = "";

    if (seconds <= 60) timeString = `${seconds} ${t("time.seconds")}`;
    else if (seconds < 480) timeString = `${seconds / 60} ${t("time.minutes")}`;
    else timeString = t("time.oneday");

    return `${sign}${tempValue} ${t("time.for")} ${timeString}`;
  }

  return (
    <div className="flex flex-col items-center gap-2 w-full">
      <h1 className="text-3xl sm:text-4xl font-bold text-zinc-900 dark:text-white text-center drop-shadow-md">
        {t("pages.home.daily.title")}
      </h1>

      <div className="text-zinc-900 dark:text-white text-center font-semibold text-base sm:text-lg drop-shadow-md">
        {t("pages.home.daily.timer")} {timerText}
      </div>

      <div className="bg-white dark:bg-zinc-900 rounded-xl p-4 sm:p-6 flex flex-col sm:flex-row items-center gap-4 sm:gap-6 w-full max-w-4xl shadow-md">
        <img
          src={getAssetPath(`/${recipe.icon}/${recipe.name}.png`)}
          className="w-24 h-24 sm:w-35 sm:h-35 object-contain flex-shrink-0 sm:ml-10"
        />
        <div className="flex flex-col flex-1 gap-4 items-center text-center">
          <div className="flex flex-col gap-1 items-center">
            <h2 className="text-xl sm:text-2xl font-bold">{t(`${recipe.prefix}.${recipe.name}`)}</h2>

            <div className="flex flex-wrap items-center justify-center gap-2">
              <img src={source.icon} className="w-7 h-7 sm:w-8 sm:h-8 object-contain" />
              <span className="text-zinc-700 dark:text-zinc-300 font-semibold">{source.name}</span>

              <button
                onClick={() => {
                  const page = source.page;
                  if (pathname !== page) {
                    router.push(`${page}?recipe=${recipe.name}`);
                  } else {
                    const element = document.getElementById(`recipe-${recipe.name}`);
                    if (element) element.scrollIntoView({ behavior: "smooth", block: "center" });
                  }
                }}
                className="ml-2 bg-zinc-200 dark:bg-zinc-700 text-zinc-900 dark:text-white hover:bg-zinc-300 dark:hover:bg-zinc-600 px-2 py-1 rounded font-semibold text-sm transition-colors cursor-pointer"
              >
                {t("pages.home.daily.details")}
              </button>
            </div>
          </div>

          <div className="flex gap-2 justify-center flex-wrap">
            <Stat icon={getAssetPath("/icons/cooking/icon_health.png")} value={recipe.health} tooltip={t("tooltips.health")} isStatus />
            <Stat icon={getAssetPath("/icons/cooking/icon_hunger.png")} value={recipe.hunger} tooltip={t("tooltips.hunger")} isStatus />
            <Stat icon={getAssetPath("/icons/cooking/icon_sanity.png")} value={recipe.sanity} tooltip={t("tooltips.sanity")} isStatus />
          </div>

          <div className="flex gap-2 flex-wrap font-bold justify-center">
            {recipe.foodtype && <FoodType type={recipe.foodtype} t={t} />}
            {recipe.temperature != null && (
              <TopEffect icon={getAssetPath("/icons/cooking/icon_temperature.png")} value={formatTemperature(recipe.temperature, recipe.temperatureDuration ?? 0)} tooltip={t("tooltips.temperature")} />
            )}
            {recipe.debuff && (
              <TopEffect icon={getAssetPath("/icons/cooking/icon_debuff.png")} value={t(`recipes_debuff.${recipe.name}`)} tooltip={t("tooltips.debuff")} />
            )}
            {recipe.characterfood &&
              (Array.isArray(recipe.characterfood) ? recipe.characterfood : [recipe.characterfood])
                .map((char) => (
                  <TopEffect key={char} icon={getAssetPath(`/icons/characters/character_${char}.png`)} value={t(`characterfood.${char}`)} tooltip={t("tooltips.characterfood")} />
                ))}
          </div>
        </div>
      </div>
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
      }
    }
  }

  const extrasMap: Record<number, Set<string>> = {};

  const addExtra = (val: number, char: string) => {
    if (!extrasMap[val]) extrasMap[val] = new Set();
    extrasMap[val].add(char);
  };

  if (stat === "hunger" && recipe?.characterfood) {
    const charValue = (recipe.hunger ?? 0) + 15;
    addExtra(charValue, recipe.characterfood);
  }

  if (recipe?.monsterfood) {
    const monsterValue = recipe[`monster${stat}`];

    if (monsterValue && monsterValue !== value) {
      addExtra(monsterValue, "webber");
      addExtra(monsterValue, "wortox");
    }
  }

  if (recipe?.mermfood) {
    const mermValue = recipe[`merm${stat}`];

    if (mermValue && mermValue !== value) {
      addExtra(mermValue, "wurt");
    }
  }

  const extraValues = Object.entries(extrasMap).map(([value, chars]) => ({
    value: Number(value),
    characters: Array.from(chars),
  }));

  return (
    <div className="relative group flex items-center gap-3 min-w-[100px] sm:min-w-[120px] justify-center">
      <img src={icon} className="w-8 h-8 sm:w-9 sm:h-9 object-contain" />

      <div className="flex flex-col items-center leading-tight">
        <span className={`text-base font-semibold ${colorClass}`}>
          {displayValue}
        </span>

        {extraValues.map((extra, i) => (
          <span
            key={i}
            className="flex items-center gap-1 text-xs text-zinc-600 dark:text-zinc-400"
          >
            (
            <span className="text-green-500 font-semibold">
              {extra.value > 0 ? `+${extra.value}` : extra.value}
            </span>

            {extra.characters.map((char) => (
              <img
                key={char}
                src={getAssetPath(`/icons/characters/character_${char}.png`)}
                className="w-5 h-5"
              />
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
        bg-black text-white dark:bg-white dark:text-black
        text-xs font-semibold
        px-3 py-1 rounded whitespace-nowrap
        shadow-lg z-50 pointer-events-none
      "
      >
        {tooltip}
      </div>
    </div>
  );
}

function FoodType({ type, t }: FoodTypeProps) {
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

function TopEffect({ icon, value, tooltip }: any) {
  return (
    <div className="relative flex items-center gap-2 bg-zinc-100 dark:bg-zinc-800 px-3 py-1 rounded-full text-xs tracking-wide group cursor-default">
      <img src={icon} className="w-5 h-5 object-contain" />

      <span className="text-zinc-900 dark:text-white">{value}</span>

      <div className="absolute bottom-full mb-2 left-1/2 -translate-x-1/2 hidden group-hover:block bg-black text-white text-xs dark:bg-white dark:text-black px-3 py-1 rounded shadow-lg z-50 whitespace-nowrap">
        {tooltip}
      </div>
    </div>
  );
}
