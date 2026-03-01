import en from "@/locales/en"
import pt from "@/locales/pt"

type Locale = "en" | "pt"

const locales = { en, pt }

// idioma padrão
let currentLocale: Locale = "en"

export function setLocale(locale: Locale) {
  currentLocale = locale
}

export function t(path: string): any {
  const keys = path.split(".")
  let result: any = locales[currentLocale]

  for (const key of keys) {
    result = result?.[key]
  }

  return result ?? path
}