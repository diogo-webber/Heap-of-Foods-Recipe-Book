"use client";

import { useState, useCallback, useRef } from "react";

interface SkeletonImageProps
  extends Omit<React.ImgHTMLAttributes<HTMLImageElement>, "className"> {
  /** Classes applied to the outer container <div>, not the <img> element. */
  className?: string;
  skeletonClassName?: string;
}

export default function SkeletonImage({
  className = "",
  skeletonClassName,
  onLoad,
  ...props
}: SkeletonImageProps) {
  const [loaded, setLoaded] = useState(false);
  const prevSrcRef = useRef(props.src);

  // Reset when src changes — inline check avoids effect ordering race with imgRef
  if (prevSrcRef.current !== props.src) {
    prevSrcRef.current = props.src;
    setLoaded(false);
  }

  // Check if already loaded (cached) when ref attaches
  const imgRef = useCallback((node: HTMLImageElement | null) => {
    if (node?.complete && node.naturalWidth > 0) {
      setLoaded(true);
    }
  }, []);

  return (
    <div
      className={`relative ${!loaded && skeletonClassName ? skeletonClassName : ""} ${className}`}
    >
      <img
        key={props.src}
        ref={imgRef}
        loading="lazy"
        {...props}
        className={`w-full h-full object-contain transition-opacity duration-100 ${loaded ? "opacity-100" : "opacity-0"}`}
        onLoad={(e) => {
          setLoaded(true);
          onLoad?.(e);
        }}
      />
    </div>
  );
}
