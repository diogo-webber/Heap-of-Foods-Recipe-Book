import { useEffect } from "react";
import { useTranslation } from "@/lib/i18n";

export function usePageTitle(title: string) {
  const { t } = useTranslation();

  useEffect(() => {
    document.title = `${t("main.title")} - ${title}`;
  }, [t, title]);
}