import type { Metadata, Viewport } from "next";
import { Plus_Jakarta_Sans } from "next/font/google";
import { config } from "@fortawesome/fontawesome-svg-core";
import "@fortawesome/fontawesome-svg-core/styles.css";

import { Footer } from "@/components/Footer";
import TopHotBar from "@/components/TopHotBar";
import { ThemeProvider } from "@/components/ThemeProvider";
import { ThemeInitializer } from "@/components/ThemeInitializer";
import "./globals.css";
import { useTranslation } from "@/lib/i18n";

config.autoAddCss = false;

const plusJakarta = Plus_Jakarta_Sans({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700", "800"],
});

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
};

export const metadata: Metadata = {
  // title: "Heap of Foods - Recipe Book",
  description: "A complete recipes sheet for the Heap of Foods Mod!",
  keywords: ["Don't Starve Together", "Heap of Foods", "Heaps of Food", "Heaps of Foods", "HoF", "Kyno"],
  authors: [{ name: "Kyno" }],
  creator: "Kyno",
  publisher: "Kyno",
  icons: {
    icon: [
      { url: "/icons/misc/icon_hof.png?v=2", sizes: "16x16", type: "image/png" },
      { url: "/icons/misc/icon_hof.png?v=2", sizes: "32x32", type: "image/png" },
      { url: "/icons/misc/icon_hof.png?v=2", sizes: "48x48", type: "image/png" }
    ],
    apple: [
      { url: "/icons/misc/icon_hof.png", sizes: "180x180", type: "image/png" }
    ],
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html 
      lang="en"
      suppressHydrationWarning
    >
      {/*
      <head>
        <script
          dangerouslySetInnerHTML={{
            __html: `(function() {
              function applyTheme() {
                try {
                  const theme = localStorage.getItem('theme') || localStorage.getItem('theme-preference');
                  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                  const isDark = theme === 'dark' || (!theme && prefersDark);
                  const html = document.documentElement;
                    if (isDark) {
                      html.classList.add('dark');
                    } else {
                      html.classList.remove('dark');
                    }
                    } catch (e) {}
                  }
                  function applyLang() {
                    try {
                      const lang = localStorage.getItem('lang');
                      if (lang === 'pt') {
                        document.documentElement.setAttribute('data-lang', 'pt');
                      } else {
                        document.documentElement.setAttribute('data-lang', 'en');
                      }
                    } catch (e) {}
                  }
                applyTheme();
                applyLang();
              })();`,
            }}
        />
        <style>{`
          html.dark {
            color-scheme: dark;
          }
          html:not(.dark) {
            color-scheme: light;
          }
          body {
            transition: background-color 0s, color 0s;
          }
        `}</style>
      </head>
      */}
      <body 
        className={`${plusJakarta.className} antialiased flex flex-col min-h-screen`}
        suppressHydrationWarning
      >
        <ThemeProvider>
          <ThemeInitializer />
          <TopHotBar />
          {children}
          <Footer />
        </ThemeProvider>
      </body>
    </html>
  );
}