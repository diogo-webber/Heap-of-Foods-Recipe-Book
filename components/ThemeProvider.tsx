"use client";

import { ThemeProvider as NextThemesProvider, type ThemeProviderProps } from "next-themes";
import { useEffect } from "react";

export function ThemeProvider({ children, ...props }: ThemeProviderProps) {
  useEffect(() => {
    // Força a aplicação do tema no próximo frame para evitar flash
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
    requestAnimationFrame(applyTheme);
  }, []);

  return (
    <NextThemesProvider 
      attribute="class" 
      defaultTheme="dark" 
      storageKey="theme"
      forcedTheme={undefined}
      disableTransitionOnChange={true}
      enableSystem={true}
      enableColorScheme={true}
      {...props}
    >
      {children}
    </NextThemesProvider>
  );
}