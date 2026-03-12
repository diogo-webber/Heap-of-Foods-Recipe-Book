"use client";

import { useTranslation } from "@/lib/i18n";
import { useRouter } from "next/navigation";
import { usePathname } from "next/navigation";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faDiscord, faSteam, faKoFi } from "@fortawesome/free-brands-svg-icons";
import { faHeart } from "@fortawesome/free-solid-svg-icons";

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
      <div className="max-w-8xl mx-auto px-6 py-5 text-grey">
        <div className="flex flex-col items-center gap-6">
          <div className="flex items-center gap-5">
            <a
              href="https://discord.gg/jjNr4Vvutn"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-grey transition"
            >
              <FontAwesomeIcon icon={faDiscord} />
              {t("footer.discord")}
            </a>

            <a
              href="https://steamcommunity.com/sharedfiles/filedetails/?id=2334209327"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-grey transition"
            >
              <FontAwesomeIcon icon={faSteam} />
              {t("footer.workshop")}
            </a>

            <a
              href="https://ko-fi.com/kynoox"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-grey transition"
            >
              <FontAwesomeIcon icon={faKoFi} />
              {t("footer.kofi")}
            </a>
          </div>

          <div className="w-full h-[2px] bg-zinc-400 dark:bg-zinc-600" />

          <p className="text-sm text-grey text-center whitespace-pre-line max-w-2xl">
            {t("footer.description")} <FontAwesomeIcon icon={faHeart} />
          </p>

          <p className="text-sm">
            © Copyright {new Date().getFullYear()} - All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
}
