/**
 * Get the base path for public assets
 * - Local: returns "/foods_cookpot/..."
 * - GitHub Pages: returns "/Heap-of-Foods-Recipe-Book/foods_cookpot/..."
 * 
 * Uses import.meta to detect basePath at build time in static exports
 */
export function getAssetPath(path: string): string {
  const basePath = process.env.NEXT_PUBLIC_BASE_PATH || "";
  const cleanPath = path.startsWith("/") ? path : `/${path}`;
  
  // In static export, basePath is set via assetPrefix in next.config.ts
  // Check if we're in a github pages environment by checking the URL
  if (typeof window !== "undefined") {
    const host = window.location.hostname;
    if (host === "imkyno.github.io") {
      return cleanPath;
    }
  }
  
  // Local
  return `${basePath}${cleanPath}`;
}
