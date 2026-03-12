import type { Metadata } from "next";
import { Plus_Jakarta_Sans } from "next/font/google";
import { config } from "@fortawesome/fontawesome-svg-core";
import "@fortawesome/fontawesome-svg-core/styles.css";

import { Footer } from "@/components/Footer";
import TopHotBar from "@/components/TopHotBar";
import { ThemeProvider } from "@/components/ThemeProvider";
import "./globals.css";
import { useTranslation } from "@/lib/i18n";

config.autoAddCss = false;

const plusJakarta = Plus_Jakarta_Sans({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700", "800"],
});

export const metadata: Metadata = {
  title: "Heap of Foods - Recipe Book",
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
      <body className={`${plusJakarta.className} antialiased flex flex-col min-h-screen`}>
        <ThemeProvider>
          <TopHotBar />
          {children}
          <Footer />
        </ThemeProvider>
      </body>
    </html>
  );
}