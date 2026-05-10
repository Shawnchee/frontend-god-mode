# Motion & Animation Reference

The line between $500 and $10,000 is motion. Static AI sites are obvious. Animated AI sites with linear easing and bounce-everywhere are even worse. This reference enforces premium motion.

## The Four Hard Rules

1. **No linear easing on UI motion.** Use spring physics or premium cubic-bezier. **Exception:** infinite seamless carousels and shimmer/marquee loops use `ease: 'linear'` — they need constant velocity to feel right. Linear is banned only for entrance, exit, hover, and tap motion.
2. **No `width`/`height`/`top`/`left` animation.** Only `transform` and `opacity` — they're hardware-accelerated.
3. **No bounce/elastic easing.** It's dated. Use spring with `damping: 20` for an overshoot that feels modern.
4. **Perpetual animations live in their own memoized Client Component.** Never trigger parent re-renders.

## The Spring Defaults

When using Framer Motion (or `motion`), apply these spring physics across the board:

```ts
const springSnappy = { type: 'spring', stiffness: 400, damping: 30 };  // buttons, taps
const springSmooth = { type: 'spring', stiffness: 100, damping: 20 };  // standard motion
const springDramatic = { type: 'spring', stiffness: 60, damping: 18 }; // hero reveals
```

For CSS-only motion, use:

```css
transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);  /* "easeOutExpo" — premium feel */
```

## Page Load — Staggered Orchestration

Never mount lists or grids instantly. Stagger them.

### Framer Motion pattern

```tsx
'use client';
import { motion } from 'framer-motion';

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.08, delayChildren: 0.1 }
  }
};

const item = {
  hidden: { opacity: 0, y: 20 },
  show: { opacity: 1, y: 0, transition: { type: 'spring', stiffness: 100, damping: 20 } }
};

export function StaggeredGrid({ items }) {
  return (
    <motion.div variants={container} initial="hidden" animate="show" className="grid gap-4">
      {items.map((it, i) => (
        <motion.div key={i} variants={item}>{it.title}</motion.div>
      ))}
    </motion.div>
  );
}
```

**Critical:** Parent variants and children MUST live in the same Client Component tree. If data is fetched async, pass it into a centralized motion wrapper.

### CSS-only fallback

```css
.stagger-item {
  opacity: 0;
  transform: translateY(20px);
  animation: rise 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
  animation-delay: calc(var(--index, 0) * 80ms);
}

@keyframes rise {
  to { opacity: 1; transform: none; }
}
```

## Magnetic Button Pattern

Buttons that pull subtly toward the cursor. **CRITICAL:** Use `useMotionValue` + `useTransform`. Never `useState` — it triggers re-renders on every mouse move and collapses mobile performance.

```tsx
'use client';
import { useRef } from 'react';
import { motion, useMotionValue, useTransform, useSpring } from 'framer-motion';

export function MagneticButton({ children }: { children: React.ReactNode }) {
  const ref = useRef<HTMLButtonElement>(null);
  const x = useMotionValue(0);
  const y = useMotionValue(0);
  const sx = useSpring(x, { stiffness: 200, damping: 20 });
  const sy = useSpring(y, { stiffness: 200, damping: 20 });

  function handleMove(e: React.MouseEvent) {
    const rect = ref.current?.getBoundingClientRect();
    if (!rect) return;
    x.set((e.clientX - rect.left - rect.width / 2) * 0.3);
    y.set((e.clientY - rect.top - rect.height / 2) * 0.3);
  }

  function handleLeave() { x.set(0); y.set(0); }

  return (
    <motion.button
      ref={ref}
      onMouseMove={handleMove}
      onMouseLeave={handleLeave}
      style={{ x: sx, y: sy }}
      className="..."
    >
      {children}
    </motion.button>
  );
}
```

## Tactile Feedback (`:active`)

Every interactive element needs a physical "push" feel:

```css
button:active { transform: translateY(1px) scale(0.98); }
```

In Framer:

```tsx
<motion.button whileTap={{ scale: 0.98, y: 1 }}>...</motion.button>
```

## Layout Transitions

Use `layout` and `layoutId` for smooth re-ordering and shared element transitions.

```tsx
<motion.div layout layoutId={`card-${id}`} transition={springSmooth}>
  {content}
</motion.div>
```

This handles list reordering, expand-to-modal morphs, and shared element transitions for free.

## Perpetual Micro-Interactions

When `MOTION_INTENSITY > 5`, embed continuous loops in standard components. Examples:

### Pulse status dot

```tsx
<motion.div
  animate={{ scale: [1, 1.15, 1], opacity: [1, 0.7, 1] }}
  transition={{ repeat: Infinity, duration: 2, ease: 'easeInOut' }}
  className="w-2 h-2 rounded-full bg-emerald-500"
/>
```

### Shimmer loading

```tsx
<motion.div
  animate={{ backgroundPosition: ['0% 0%', '100% 0%'] }}
  transition={{ repeat: Infinity, duration: 1.5, ease: 'linear' }}
  className="bg-[linear-gradient(90deg,transparent,rgba(255,255,255,0.1),transparent)] bg-[length:200%_100%]"
/>
```

### Float

```tsx
<motion.div
  animate={{ y: [0, -8, 0] }}
  transition={{ repeat: Infinity, duration: 3, ease: 'easeInOut' }}
/>
```

### Typewriter (multi-prompt cycling)

Cycle through 3-4 prompts with blinking cursor + 1.5s pause between cycles. Used in hero search bars or AI command inputs.

### Carousel (infinite seamless)

```tsx
<motion.div
  animate={{ x: ['0%', '-100%'] }}
  transition={{ repeat: Infinity, duration: 30, ease: 'linear' }}
  className="flex"
>
  {[...items, ...items].map(...)}
</motion.div>
```

## Scroll-Driven Effects

Use Framer's `useScroll` + `useTransform`. Never `window.addEventListener('scroll')` — kills performance.

```tsx
const { scrollYProgress } = useScroll({ target: ref, offset: ['start end', 'end start'] });
const y = useTransform(scrollYProgress, [0, 1], [0, -100]);
return <motion.div style={{ y }} />;
```

For complex scrolltelling beyond Framer (parallax sequences, ScrollTrigger pinning), use **GSAP**. **Never mix GSAP with Framer in the same component tree** — wrap GSAP in strict `useEffect` cleanup blocks and isolate to full-page sections or canvas backgrounds.

## Performance Guards

- **DOM cost:** Apply grain/noise filters only to fixed `pointer-events-none` overlays. Never on scrolling containers.
- **`will-change: transform`** sparingly — only on elements actively animating.
- **Always cleanup** `useEffect` animations:
  ```tsx
  useEffect(() => {
    const ctx = gsap.context(() => { /* ... */ }, ref);
    return () => ctx.revert();
  }, []);
  ```
- **Memoize perpetual-motion components** with `React.memo` and isolate them.
- **`<AnimatePresence>`** wraps lists with mount/unmount animations. Always include `mode="popLayout"` if items can reorder.

## Reduced Motion

Always respect:

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

In Framer Motion:

```tsx
import { useReducedMotion } from 'framer-motion';
const reduced = useReducedMotion();
const transition = reduced ? { duration: 0 } : springSmooth;
```

## Anti-Patterns

- ❌ Animating `width`, `height`, `top`, `left` — repaints, not GPU
- ❌ `useState` for hover position — re-renders kill mobile
- ❌ Linear easing on UI — feels robotic
- ❌ Bounce / elastic — feels dated (2014 mobile vibes)
- ❌ Custom mouse cursor replacements — outdated, breaks accessibility
- ❌ Mixing GSAP + Framer in the same component
- ❌ `scrollY` listeners on window — use `useScroll`
- ❌ Animation duration over 600ms for UI motion (heroes can go longer)

## Final Motion Audit

- [ ] Spring physics on all interactive motion
- [ ] No `width`/`height` animations
- [ ] List reveals are staggered (not instant mount)
- [ ] Perpetual loops are in memoized leaf Client Components
- [ ] Reduced-motion respected
- [ ] `useEffect` cleanup on every animation hook
- [ ] No bounce/elastic easing
- [ ] No custom mouse cursors
- [ ] All `motion.*` components have `'use client'` at top of file
