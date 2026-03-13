"use client";

import { useEffect } from "react";
import { useTheme } from "next-themes";
import { setLocale } from "@/lib/i18n";

export function ThemeInitializer() {
  const { theme, setTheme, systemTheme } = useTheme();

  useEffect(() => {
    // Sincroniza idioma e tema globais
    try {
      const savedLang = localStorage.getItem("lang");
      if (savedLang === "en" || savedLang === "pt") {
        setLocale(savedLang);
      }
    } catch (e) {}

    // Garante que o tema está aplicado corretamente após hidratação
    const savedTheme = localStorage.getItem("theme");
    
    if (savedTheme === "dark" || savedTheme === "light") {
      setTheme(savedTheme);
    } else if (systemTheme === "dark") {
      setTheme("dark");
    }
  }, [setTheme, systemTheme]);

  // Monitora mudanças no localStorage
  useEffect(() => {
    const applyTheme = () => {
      try {
        const theme = localStorage.getItem('theme');
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        const isDark = theme === 'dark' || (!theme && prefersDark);
        const html = document.documentElement;
        
        if (isDark) {
          html.classList.add('dark');
        } else {
          html.classList.remove('dark');
        }
      } catch (e) {}
    };
    
    applyTheme();
    const timeouts = [
      setTimeout(applyTheme, 0),
      setTimeout(applyTheme, 50),
      setTimeout(applyTheme, 100),
    ];

    return () => timeouts.forEach(t => clearTimeout(t));
  }, []);

  // Observer global para garantir que a classe não seja removida
  useEffect(() => {
    const observer = new MutationObserver(() => {
      try {
        const theme = localStorage.getItem('theme');
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        const isDark = theme === 'dark' || (!theme && prefersDark);
        const html = document.documentElement;
        
        if (isDark && !html.classList.contains('dark')) {
          html.classList.add('dark');
        }
      } catch (e) {}
    });

    observer.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['class'],
    });

    return () => observer.disconnect();
  }, []);

  // Listener para mudanças no localStorage (sincroniza entre abas)
  useEffect(() => {
    const handleStorageChange = (e: StorageEvent) => {
      if (e.key === 'theme') {
        const newTheme = e.newValue as 'light' | 'dark' | null;
        if (newTheme === 'light' || newTheme === 'dark') {
          setTheme(newTheme);
        }
      }
      if (e.key === 'lang') {
        if (e.newValue === 'en' || e.newValue === 'pt') {
          setLocale(e.newValue);
        }
      }
    };

    window.addEventListener('storage', handleStorageChange);
    return () => window.removeEventListener('storage', handleStorageChange);
  }, [setTheme]);

  return null;
}
