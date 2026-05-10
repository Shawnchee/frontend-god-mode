# Bento 2.0 — The Motion-Engine Paradigm

For modern SaaS dashboards and feature sections, this is your default architecture. Vercel-core meets Dribbble-clean. Heavy on perpetual physics.

## When to Use This

- Modern SaaS landing page "feature row"
- Product page showcasing 4-6 capabilities
- Dashboard hero showcasing "what the product does"
- Anywhere the brief says: "show off the product features in a modern, animated way"

## The Aesthetic

**Use the project's tokens from `DESIGN.md` — never hardcode Zinc/Slate/Stone.** Values below are illustrative; replace with the project's actual neutral family.

- **Background:** the project's `--bg-subtle` (e.g., `oklch(0.985 0.005 H)` where H matches the chosen hue family)
- **Card surface:** the project's `--surface` (e.g., off-white in light mode, `oklch(0.18 0.005 H)` in dark)
- **Card border:** `border border-[var(--border)]/60` — token, not literal `border-zinc-200`
- **Card radius:** `rounded-[2.5rem]` — distinctive, not default `rounded-2xl`
- **Diffusion shadow:** wide + low-opacity + tinted toward bg hue (see `color.md`). NOT `rgba(0,0,0,...)`.
- **Internal padding:** `p-8 md:p-10`
- **Title placement:** OUTSIDE and BELOW the cards (gallery-style), not inside

## The Grid

```tsx
<section className="bg-zinc-50 py-24">
  <div className="max-w-7xl mx-auto px-6 md:px-10">
    {/* Eyebrow + heading */}
    <div className="mb-16 max-w-2xl">
      <p className="text-sm tracking-wide uppercase text-zinc-500 mb-3">What's inside</p>
      <h2 className="text-4xl md:text-5xl tracking-tighter">
        The motion engine, fully realized.
      </h2>
    </div>

    {/* Bento grid — 3 cols, 2 rows, asymmetric spans */}
    <div className="grid grid-cols-1 md:grid-cols-3 md:grid-rows-2 gap-4">
      <Card span="md:col-span-2 md:row-span-2">
        <IntelligentList />
      </Card>
      <Card>
        <CommandInput />
      </Card>
      <Card>
        <LiveStatus />
      </Card>
    </div>
  </div>
</section>
```

## The 5 Card Archetypes

Each card MUST have a perpetual micro-animation. These are the proven five:

### 1. The Intelligent List

A vertical stack of items with infinite auto-sorting. Items swap positions using `layoutId`. Simulates an AI prioritizing tasks.

```tsx
'use client';
import { motion, LayoutGroup } from 'framer-motion';
import { useEffect, useState } from 'react';

const tasks = [
  { id: 1, label: 'Draft Q3 launch plan', priority: 'high' },
  { id: 2, label: 'Review onboarding flow', priority: 'med' },
  { id: 3, label: 'Sync with marketing', priority: 'low' },
  { id: 4, label: 'Update docs site', priority: 'med' },
];

export function IntelligentList() {
  const [items, setItems] = useState(tasks);
  useEffect(() => {
    const t = setInterval(() => {
      setItems((prev) => [...prev].sort(() => Math.random() - 0.5));
    }, 3000);
    return () => clearInterval(t);
  }, []);

  return (
    <LayoutGroup>
      <ul className="space-y-3">
        {items.map((task) => (
          <motion.li
            key={task.id}
            layout
            layoutId={`task-${task.id}`}
            transition={{ type: 'spring', stiffness: 100, damping: 20 }}
            className="rounded-2xl bg-zinc-50 p-4 flex items-center gap-3"
          >
            <span className={`w-2 h-2 rounded-full bg-emerald-500`} />
            <span className="text-sm">{task.label}</span>
          </motion.li>
        ))}
      </ul>
    </LayoutGroup>
  );
}
```

### 2. The Command Input

Search/AI bar with multi-step typewriter cycling through realistic prompts. Includes blinking cursor and shimmer "processing" state.

Loops through 3-4 prompts:
- "Draft a launch announcement..."
- "Find churn signals from last quarter..."
- "Suggest pricing for the enterprise tier..."

Each prompt: 2.5s typing → 1s pause → shimmer for 0.8s → fade out → next prompt.

### 3. The Live Status

Scheduling / calendar interface with breathing status indicators. Notification badge pops in with overshoot spring (`damping: 12`), holds for 3s, vanishes.

```tsx
<motion.div
  initial={{ scale: 0, opacity: 0 }}
  animate={{ scale: 1, opacity: 1 }}
  exit={{ scale: 0, opacity: 0 }}
  transition={{ type: 'spring', stiffness: 300, damping: 12 }}
  className="absolute top-4 right-4 px-3 py-1 rounded-full bg-rose-500 text-white text-xs"
>
  3 new
</motion.div>
```

### 4. The Wide Data Stream

Horizontal infinite carousel of metric cards. Seamless loop using `x: ['0%', '-100%']` with duplicated content.

```tsx
<motion.div
  animate={{ x: ['0%', '-50%'] }}
  transition={{ repeat: Infinity, duration: 30, ease: 'linear' }}
  className="flex gap-4 w-max"
>
  {[...metrics, ...metrics].map((m, i) => (
    <MetricCard key={i} {...m} />
  ))}
</motion.div>
```

### 5. The Contextual UI (Focus Mode)

A document/text view that animates a staggered highlight sweeping across a paragraph, followed by a floating action toolbar that "Float-ins" with micro-icons (highlight, comment, summarize).

## Performance — Critical Rules

- **Memoize every animated card** with `React.memo`
- **Each card lives in its OWN tiny Client Component** — never put 3 perpetual loops in one component
- **Wrap dynamic lists** in `<AnimatePresence>` with `mode="popLayout"`
- **No re-renders on the parent layout** when cards animate
- **Cleanup intervals** in `useEffect` returns

## Spring Defaults for Bento

```ts
const springSmooth = { type: 'spring', stiffness: 100, damping: 20 };  // standard
const springSnappy = { type: 'spring', stiffness: 400, damping: 30 };  // taps
const springOvershoot = { type: 'spring', stiffness: 300, damping: 12 }; // notifications, badges
```

## Common Bento Mistakes

- ❌ All cards the same size (1:1:1) — must be asymmetric
- ❌ No motion in any card — must be alive
- ❌ Title INSIDE the card — put it OUTSIDE, below
- ❌ Default `rounded-2xl` — use `rounded-[2.5rem]`
- ❌ `shadow-md` — use diffusion shadow
- ❌ Padding under `p-6` — needs to breathe
- ❌ Putting all 5 archetypes in one section — pick 3-4 max
- ❌ Same archetype on every card — vary them

## Mobile Behavior

Below `md:`, the bento grid collapses:
- All `col-span` becomes 1
- Stack vertically
- Disable horizontal carousels (use static grid)
- Reduce padding to `p-6`
- Keep perpetual motion ONLY on the most prominent card (performance)
