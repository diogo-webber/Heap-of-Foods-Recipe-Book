"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter } from "next/router";
import { useTheme } from "next-themes";
import { t, useTranslation, type Locale } from "@/lib/i18n";
import { usePageTitle } from "@/components/PageTitle";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faSun,
  faMoon,
  faLanguage,
  faChevronDown,
  faArrowRightFromBracket
} from "@fortawesome/free-solid-svg-icons";

interface SettingsProps {
  initialLanguage?: string;
  onLanguageChange?: (lang: Locale) => void;
}

type Lang = "en" | "pt";

const LANGUAGES = [
  { code: "en", label: "English" },
  { code: "pt", label: "Português" },
];

export default function Settings({
  initialLanguage = "en",
  onLanguageChange,
}: SettingsProps) {
  const { theme, setTheme } = useTheme();
  const { locale, setLocale: setGlobalLocale } = useTranslation();

  const isDarkMode = theme === "dark";

  const [language, setLanguage] = useState<Lang>("en");
  const [langOpen, setLangOpen] = useState(false);
  const langRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const savedLang = localStorage.getItem("lang");
    if (savedLang) {
      setLanguage(savedLang as Lang);
      setGlobalLocale(savedLang as Lang);
    }
  }, [setGlobalLocale]);

  const toggleDarkMode = () => setTheme(isDarkMode ? "light" : "dark");

  const handleLanguageChange = (lang: Lang) => {
    setLanguage(lang);
    setGlobalLocale(lang);
    localStorage.setItem("lang", lang);
    setLangOpen(false);
  };

  const currentLang = LANGUAGES.find((l) => l.code === language);

  usePageTitle(t("pages.settings.title")); 

  return (
    <div className="min-h-screen bg-zinc-300 dark:bg-zinc-800 text-zinc-900 dark:text-white flex flex-col items-center p-8 pt-20">
      <h1 className="text-4xl font-bold mb-8 drop-shadow-md">
        {t("settings.title") || "Settings"}
      </h1>

      {/* CARD */}
      <div className="w-full max-w-md min-w-[300px] bg-white dark:bg-zinc-900 rounded-xl shadow-md p-6 flex flex-col gap-6">
        {/* THEME CARD */}
        <div className="flex items-center justify-between bg-zinc-200 dark:bg-zinc-800 p-4 rounded-lg">
          <span className="font-bold">
            {isDarkMode ? t("settings.theme.dark") : t("settings.theme.light")}
          </span>
          <button
            onClick={toggleDarkMode}
            className={`relative w-14 h-7 rounded-full cursor-pointer transition-colors ${isDarkMode ? "bg-zinc-100 dark:bg-zinc-700" : "bg-zinc-300 dark:bg-zinc-800"}`}
          >
            <span
              className={`absolute top-0.5 flex items-center justify-center w-6 h-6 bg-zinc-100 dark:bg-white rounded-full shadow transition-transform ${isDarkMode ? "translate-x-7" : "translate-x-1"}`}
            >
              <FontAwesomeIcon
                icon={isDarkMode ? faMoon : faSun}
                className="text-zinc-800 dark:text-zinc-800 text-xs"
              />
            </span>
          </button>
        </div>

        {/* LANGUAGE CARD */}
        <div className="relative" ref={langRef}>
          <label className="font-bold mb-2 flex items-center gap-2">
            <FontAwesomeIcon
              icon={faLanguage}
            />
            {t("settings.lang")}
          </label>
          <button
            onClick={() => setLangOpen(!langOpen)}
            className="w-full font-bold bg-zinc-200 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 rounded-lg px-3 py-2 flex items-center justify-between transition cursor-pointer"
          >
            <span>{currentLang?.label}</span>
            <FontAwesomeIcon
              icon={faChevronDown}
              className={`transition ${langOpen ? "rotate-180" : ""}`}
            />
          </button>

          {/* LANGUAGE DROPDOWN */}
          {langOpen && (
            <div className="absolute top-full left-0 w-full mt-1 bg-zinc-200 dark:bg-zinc-900 rounded-lg overflow-hidden shadow-lg z-50">
              {LANGUAGES.map((lang) => (
                <button
                  key={lang.code}
                  onClick={() => handleLanguageChange(lang.code as Lang)}
                  className="w-full text-left px-3 py-2 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition cursor-pointer"
                >
                  {lang.label}
                </button>
              ))}
            </div>
          )}
        </div>
      </div>
      <button
        onClick={() => window.history.back()}
        className="
        font-bold
        mt-5 z-10 px-6 py-3 bg-zinc-100 
        dark:bg-zinc-900 text-zinc-900 
        dark:text-white rounded-lg 
        hover:bg-zinc-200 dark:hover:bg-zinc-700 
        transition relative shadow-md
        cursor-pointer
        flex items-center gap-2
        "
      >
        <FontAwesomeIcon
          icon={faArrowRightFromBracket}
          className="rotate-180"
        />
        {t("settings.backtopage")}
      </button>
    </div>
  );
}
