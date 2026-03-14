"use client";

import { useState, useEffect, useRef } from "react";

interface AnimatedOverlayProps {
  isOpen: boolean;
  onClose: () => void;
  children: React.ReactNode;
}

export default function AnimatedOverlay({
  isOpen,
  onClose,
  children,
}: AnimatedOverlayProps) {
  const [shouldRender, setShouldRender] = useState(false);
  const [phase, setPhase] = useState<
    "idle" | "entering" | "visible" | "exiting"
  >("idle");
  const childrenRef = useRef<React.ReactNode>(children);

  // Cache children while open so they persist during exit animation
  if (isOpen) {
    childrenRef.current = children;
  }

  useEffect(() => {
    if (isOpen) {
      if (phase === "idle" || phase === "exiting") {
        setShouldRender(true);
        requestAnimationFrame(() => {
          requestAnimationFrame(() => {
            setPhase("entering");
          });
        });
      }
    } else {
      if (phase === "entering" || phase === "visible") {
        setPhase("exiting");
      }
    }
  }, [isOpen]);

  const handleAnimationEnd = (e: React.AnimationEvent) => {
    if (e.target !== e.currentTarget) return;
    if (phase === "exiting") {
      setShouldRender(false);
      setPhase("idle");
    }
  };

  if (!shouldRender) return null;

  const overlayClass =
    phase === "entering"
      ? "overlay-enter"
      : phase === "exiting"
        ? "overlay-exit"
        : phase === "visible"
          ? ""
          : "overlay-before-enter";

  return (
    <div
      className={`fixed inset-0 bg-black/70 flex items-center justify-center z-50 ${overlayClass}`}
      onClick={onClose}
      onAnimationEnd={handleAnimationEnd}
    >
      {childrenRef.current}
    </div>
  );
}
