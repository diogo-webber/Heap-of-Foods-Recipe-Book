"use client"

import { t } from "@/lib/i18n"
import { useRouter } from "next/navigation"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faDiscord, faSteam, faKoFi } from "@fortawesome/free-brands-svg-icons"

export function Footer() {
  const router = useRouter()

  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: "smooth" })
  }

  return (
    <footer className="border-t border-zinc-800 bg-zinc-900 font-bold">
      <div className="max-w-8xl mx-auto px-6 py-10 text-zinc-400">

        <div className="flex flex-col items-center gap-6">
          <div className="flex items-center gap-5">
            <a
              href="https://discord.gg/jjNr4Vvutn"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-white transition"
            >
              <FontAwesomeIcon icon={faDiscord} />
              {t("footer.discord")}
            </a>

            <a
              href="https://steamcommunity.com/sharedfiles/filedetails/?id=2334209327"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-white transition"
            >
              <FontAwesomeIcon icon={faSteam} />
              {t("footer.workshop")}
            </a>

            <a
              href="https://ko-fi.com/kynoox"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 hover:text-white transition"
            >
              <FontAwesomeIcon icon={faKoFi} />
              {t("footer.kofi")}
            </a>
          </div>

          <div className="w-full h-[2px] bg-zinc-400" />

          <p className="text-sm text-zinc-500 text-center whitespace-pre-line max-w-2xl">
            {t("footer.description")}
          </p>

          <p className="text-sm">
            © Copyright {new Date().getFullYear()} - All rights reserved.
          </p>
        </div>

        <div className="mt-6 flex justify-center gap-2">
          <button
            onClick={() => router.push("/")}
            className="flex items-center gap-2 text-sm bg-zinc-800 hover:bg-zinc-700 px-4 py-2 rounded-lg transition"
          >
            {t("footer.mainpage")}
          </button>

          <button
            onClick={scrollToTop}
            className="flex items-center gap-2 text-sm bg-zinc-800 hover:bg-zinc-700 px-4 py-2 rounded-lg transition"
          > 
            {t("footer.backtotop")}
          </button>
        </div>
      </div>
    </footer>
  )
}