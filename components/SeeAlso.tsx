"use client";

import { useTranslation } from "@/lib/i18n";
import type { RecipeInput } from "@/lib/recommend";

interface SeeAlsoProps {
  suggested: RecipeInput;
  imageBasePath: string;
  translationPrefix: string;
  onSelect: (recipe: RecipeInput) => void;
}

export default function SeeAlso({
  suggested,
  imageBasePath,
  translationPrefix,
  onSelect,
}: SeeAlsoProps) {
  const { t } = useTranslation();

  return (
    <div className="flex items-center justify-center gap-3 mt-4 pt-4 border-t-4 border-zinc-200 dark:border-zinc-700">
      <span className="text-sm font-semibold text-zinc-500 dark:text-zinc-400">
        {t("seealso.label")}:
      </span>
      <button
        onClick={() => onSelect(suggested)}
        className="flex items-center gap-2 px-3 py-1.5 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-200 dark:hover:bg-zinc-700 transition cursor-pointer"
        aria-label={`${t("seealso.label")}: ${t(`${translationPrefix}.${suggested.name}`)}`}
      >
        <img
          src={`${imageBasePath}/${suggested.name}.png`}
          className="w-8 h-8 object-contain"
          alt={t(`${translationPrefix}.${suggested.name}`)}
        />
        <span className="text-sm font-semibold text-zinc-900 dark:text-white">
          {t(`${translationPrefix}.${suggested.name}`)}
        </span>
      </button>
    </div>
  );
}
