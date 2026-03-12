"use client";

import Settings from "@/components/Settings";
import { useTranslation, type Locale } from "@/lib/i18n";

export default function SettingsPage() {
  const { locale, setLocale } = useTranslation();

  return (
    <div className="min-h-screen bg-zinc-300 dark:bg-zinc-800 flex items-center justify-center">
      <Settings
        initialLanguage={locale}
        onLanguageChange={(lang: Locale) => setLocale(lang)}
      />
    </div>
  );
}