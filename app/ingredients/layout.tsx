"use client";

import { Suspense, ReactNode } from "react";

export default function IngredientsLayout({ children }: { children: ReactNode }) {
  return (
    <Suspense fallback={<div className="flex items-center justify-center min-h-screen">Loading...</div>}>
      {children}
    </Suspense>
  );
}
