"use client";

import { useTranslation } from "@/lib/i18n";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faHouse, faGear, faUtensils } from "@fortawesome/free-solid-svg-icons";
import { usePathname } from "next/navigation";
import Link from "next/link";

export default function TopHotBar() {
  const { t, locale } = useTranslation();
  const pathname = usePathname();

  if (pathname === "/") return null;

  return (
    <div 
      key={locale}
      className="fixed top-0 left-0 w-full z-50 bg-zinc-200 dark:bg-zinc-900 shadow-md flex items-center justify-between p-2">
      <div className="flex items-center">
        <Link href="/">
          <button className="flex items-center gap-2 px-3 py-3 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <FontAwesomeIcon icon={faHouse} className="w-6 h-6" />
          </button>
        </Link>
      </div>

      <div className="flex items-center justify-center gap-2">
        <Link href="/recipes_cookpot">
          <button className="flex items-center gap-2 px-3 py-2 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <img src="/icons/misc/icon_cookpot.png" className="w-6 h-6 object-contain"/>
            {t("main.cookpot")}
          </button>
        </Link>

        <Link href="/recipes_warly">
          <button className="flex items-center gap-2 px-3 py-2 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <img src="/icons/misc/icon_cookpot_warly.png" className="w-6 h-6 object-contain"/>
            {t("main.cookpot_warly")}
          </button>
        </Link>

        <Link href="/recipes_keg">
          <button className="flex items-center gap-2 px-3 py-2 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <img src="/icons/misc/icon_cookpot_keg.png" className="w-6 h-6 object-contain"/>
            {t("main.cookpot_keg")}
          </button>
        </Link>

        <Link href="/recipes_jar">
          <button className="flex items-center gap-2 px-3 py-2 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <img src="/icons/misc/icon_cookpot_jar.png" className="w-6 h-6 object-contain"/>
            {t("main.cookpot_jar")}
          </button>
        </Link>

        <Link href="/recipes_seasonal">
          <button className="flex items-center gap-2 px-3 py-2 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <img src="/icons/misc/icon_cookpot_seasonal.png" className="w-6 h-6 object-contain"/>
            {t("main.cookpot_seasonal")}
          </button>
        </Link>

        <Link href="/ingredients">
          <button className="flex items-center gap-2 px-3 py-2 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <img src="/icons/misc/icon_ingredients.png" className="w-6 h-6 object-contain"/>
            {t("main.ingredients")}
          </button>
        </Link>
      </div>

      <div className="flex items-center">
        <Link href="/settings">
          <button className="flex items-center gap-2 px-3 py-3 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-300 dark:hover:bg-zinc-700 transition font-bold cursor-pointer">
            <FontAwesomeIcon icon={faGear} className="w-6 h-6" />
          </button>
        </Link>
      </div>
    </div>
  );
}
