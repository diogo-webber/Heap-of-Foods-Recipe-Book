"use client";

import { useTranslation } from "@/lib/i18n";
import { useRouter } from "next/navigation";
import { usePathname } from "next/navigation";
import Link from "next/link";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faDiscord, faSteam, faKoFi } from "@fortawesome/free-brands-svg-icons";
import { faHeart, faUsers } from "@fortawesome/free-solid-svg-icons";

export function Footer() {
  const { t } = useTranslation();
  const router = useRouter();

  const pathname = usePathname();

  if (pathname === "/") return null;
  if (pathname === "/settings") return null;

  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  return (
    <footer className="bg-zinc-200 dark:bg-zinc-900 font-bold">
      <div className="max-w-8xl mx-auto px-3 sm:px-6 py-3 sm:py-5 text-grey">
          <div className="flex flex-col items-center gap-3 sm:gap-6">
          <div className="flex items-center gap-3 sm:gap-5">
            <a
              href="https://steamcommunity.com/sharedfiles/filedetails/?id=2334209327"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-grey transition"
            >
              <FontAwesomeIcon icon={faSteam} />
              <span className="hidden sm:inline">{t("footer.workshop")}</span>
            </a>

            <a
              href="https://discord.gg/jjNr4Vvutn"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-grey transition"
            >
              <FontAwesomeIcon icon={faDiscord} />
              <span className="hidden sm:inline">{t("footer.discord")}</span>
            </a>

            <Link
              href="/contributors"
              className="flex items-center gap-2 hover:text-grey transition"
            >
              <FontAwesomeIcon icon={faUsers} />
              <span className="hidden sm:inline">{t("footer.contributors")}</span>
            </Link>

            <a
              href="https://ko-fi.com/kynoox"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-grey transition"
            >
              <FontAwesomeIcon icon={faKoFi} />
              <span className="hidden sm:inline">{t("footer.kofi")}</span>
            </a>
          </div>

          <div className="w-full h-[2px] bg-zinc-400 dark:bg-zinc-600" />

          <p className="text-sm text-grey text-center whitespace-pre-line max-w-2xl">
            {t("footer.description")} <FontAwesomeIcon icon={faHeart} />
          </p>

          <p className="text-sm">
            {t("footer.copyright", { year: new Date().getFullYear() })}
          </p>
        </div>
      </div>
    </footer>
  );
}
