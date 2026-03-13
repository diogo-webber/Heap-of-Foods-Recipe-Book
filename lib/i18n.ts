
import { useState, useEffect, useContext, createContext } from "react"
import en from "@/locales/en"
import pt from "@/locales/pt"

export type Locale = "en" | "pt"

const locales = { en, pt }

// Contexto para gerenciar locale globalmente
const LocaleContext = createContext<Locale>("en")

let currentLocale: Locale = "en"
let listeners: (() => void)[] = []

export function setLocale(locale: Locale) {
  currentLocale = locale
  if (typeof window !== "undefined") {
    localStorage.setItem("lang", locale)
  }
  listeners.forEach((fn) => fn())
}

export function getLocale(): Locale {
  return currentLocale
}

export function t(path: string, params?: Record<string, string | number>): string {
  // Usa o locale global que foi sincronizado
  const activeLocale = currentLocale
  const keys = path.split(".")

  let result: any = locales[activeLocale]
  for (const key of keys) {
    result = result?.[key]
  }

  if (result === undefined || result === null) {
    let fallback: any = locales["en"]
    for (const key of keys) {
      fallback = fallback?.[key]
    }
    result = fallback ?? path
  }

  if (typeof result !== "string") return path

  if (params) {
    result = result.replace(/\{\{(\w+)\}\}/g, (_: string, key: string) =>
      params[key] !== undefined ? String(params[key]) : `{{${key}}}`
    )
  }

  return result
}

// HOOK
export function useTranslation() {
  const [locale, setLocaleState] = useState<Locale>("en")
  const [isClient, setIsClient] = useState(false)

  useEffect(() => {
    setIsClient(true)
    
    // Sincroniza com o localStorage quando o componente monta
    const saved = localStorage.getItem("lang")
    const initialLocale = (saved === "en" || saved === "pt") ? saved : "en"
    
    // Atualiza o locale global
    currentLocale = initialLocale
    setLocaleState(initialLocale)

    const listener = () => {
      setLocaleState(getLocale())
    }
    listeners.push(listener)
    
    return () => {
      listeners = listeners.filter((l) => l !== listener)
    }
  }, [])

  return { t, locale: isClient ? locale : "en", setLocale }
}