# Layout & Spatial Reference

Generic AI sites get caught here: centered hero + 3 equal feature cards + footer. Refuse this default. Layout is where you signal taste.

## The Layout Bans

- **Centered hero with H1 + subtitle + 2 buttons.** Banned when DESIGN_VARIANCE > 4. Use split-screen (50/50), left-aligned content + right asset, or asymmetric whitespace.
- **3 equal cards in a row** as the features section. Use 2-col zig-zag, asymmetric bento, horizontal scroll, or `divide-y` rows.
- **Cards inside cards inside cards.** Pick the lowest depth that communicates the hierarchy.
- **`h-screen`** on full-height sections. Always `min-h-[100dvh]`.
- **Flex math** like `w-[calc(33%-1rem)]`. Use CSS Grid: `grid-cols-3 gap-6`.
- **Containers wider than `max-w-[1400px]`** without intentional reason.
- **Default `gap-4`** on every grid. Vary spacing — tighter for data, looser for editorial.

## Hero Patterns That Don't Suck

### Split screen (default for SaaS)
- 50/50 or 60/40
- Text on left (left-aligned, NOT center), large image/video/visual on right
- Image bleeds to edge of viewport
- Subtle fade from image into bg color (top + bottom), darkening for dark mode, lightening for light

### Editorial / left-aligned
- Massive H1 left-aligned, breaking grid
- Body text starts at column 2 of a 4-col grid
- Image overlaps H1 by ~10% intentional collision

### Asymmetric whitespace
- H1 in upper-left
- Subtext in lower-right
- 60% of the canvas is empty
- Works for luxury, minimalist, gallery aesthetics

### Bento hero
- 60% main visual / 40% stacked metadata cards
- Mobile collapses metadata under main visual

### Diagonal flow
- Content + visuals zig-zag down the page on alternating sides
- Each row breaks the grid slightly
- Works for storytelling, longer-form pages

## Bento Grid (For Feature Sections)

The modern way to show "3-5 things" without 3 equal cards.

### Structure

```tsx
<div className="grid grid-cols-1 md:grid-cols-3 md:grid-rows-2 gap-4 max-w-7xl mx-auto p-8">
  <div className="md:col-span-2 md:row-span-2 rounded-[2.5rem] bg-white p-10 border border-zinc-200/50">
    {/* Hero card — biggest */}
  </div>
  <div className="rounded-[2.5rem] bg-white p-8 border border-zinc-200/50">
    {/* Top-right */}
  </div>
  <div className="rounded-[2.5rem] bg-white p-8 border border-zinc-200/50">
    {/* Bottom-right */}
  </div>
</div>
```

### Bento principles

- **Asymmetric column / row spans** — never 1:1:1
- **Generous internal padding** — `p-8` minimum, `p-10` for hero cards
- **Subtle 1px border** in `border-zinc-200/50` (or matched dark equivalent)
- **Diffusion shadow** — wide, low-opacity, tinted
- **Rounded `[2.5rem]`** — distinctive, not the default `rounded-2xl`
- **Labels OUTSIDE cards** — title + description below the card, gallery-style

See `references/bento-engine.md` for the full Motion-Engine Bento spec.

## Spacing System

Use Tailwind's spacing scale, but vary purposefully:

| Density target  | Internal padding | Gap between blocks | Section gap     |
|-----------------|------------------|--------------------|-----------------|
| Airy (1-3)      | `p-12 md:p-16`   | `gap-8 md:gap-12`  | `py-24 md:py-32`|
| Daily (4-7)     | `p-6 md:p-8`     | `gap-4 md:gap-6`   | `py-16 md:py-24`|
| Cockpit (8-10)  | `p-3 md:p-4`     | `gap-2 md:gap-3`   | `py-8 md:py-12` |

## Containers

- **Page wrap:** `max-w-[1400px] mx-auto px-6 md:px-10` (default)
- **Reading width:** `max-w-prose` or `max-w-[65ch]` for body copy
- **Wide hero:** `w-full` (no max) for edge-to-edge visuals
- **Tight container:** `max-w-3xl mx-auto` for marketing copy

## Mobile Override (Critical)

Any asymmetric / high-variance layout MUST collapse cleanly below `md:`:

```tsx
<div className="grid grid-cols-1 md:grid-cols-3 md:grid-rows-2 gap-4 px-4 md:px-10 py-12 md:py-24">
```

- All `grid-cols-N` becomes `grid-cols-1`
- Padding drops to `px-4 py-8` minimum
- Display fonts scale down meaningfully (`text-4xl md:text-7xl`)
- No horizontal scroll allowed under any circumstances

## Dashboard Hardening (VISUAL_DENSITY > 7)

Dense data UIs should not box every metric in a card.

### Use these instead of cards:

- **`divide-y divide-zinc-200/60`** between data rows
- **`border-t`** to separate sections
- **Negative space** with monospace numbers
- **Tabular columns** with `font-mono` and right-aligned numerics
- **Sparklines / trendlines inline** with the metric

### When to keep cards:

- Elevation has functional meaning (modal, popover, dropdown)
- Z-index communicates state (selected item)
- Visual grouping is genuinely needed

Otherwise: **delete the cards.**

## Z-Index Hygiene

Don't spam `z-50` and `z-10`. Use a system:

```css
:root {
  --z-base: 0;
  --z-sticky-nav: 30;
  --z-dropdown: 40;
  --z-overlay: 50;
  --z-modal: 60;
  --z-toast: 70;
  --z-tooltip: 80;
}
```

## Anti-Patterns Checklist

- [ ] No centered hero (when variance > 4)
- [ ] No 3 equal feature cards in a row
- [ ] No nested cards beyond depth 1
- [ ] No `h-screen` (use `min-h-[100dvh]`)
- [ ] No flex percentage math (use Grid)
- [ ] All asymmetric layouts collapse cleanly on mobile
- [ ] No horizontal scroll on any viewport
- [ ] Spacing varies between sections (not `gap-4` everywhere)
- [ ] Z-index uses systemic tokens, not random `z-50`s
- [ ] Containers don't randomly drop to `max-w-md` or `max-w-7xl` without reason
