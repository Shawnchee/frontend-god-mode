# Accessibility Reference

Production-grade work means accessible work. This isn't optional. Generic AI output skips a11y entirely — don't.

## The Hard Floor

- **WCAG 2.2 AA contrast ratios:**
  - Body text on background: **≥ 4.5:1**
  - Large text (≥ 18pt or 14pt bold): **≥ 3:1**
  - UI components, focus indicators, graphical elements: **≥ 3:1**
- **All interactive elements** must be keyboard-reachable in a logical tab order.
- **Focus rings** must be visible. Never `outline: none` without a replacement.
- **Reduced motion** must be respected (see motion.md).

## Contrast Calibration

When using OKLCH neutrals:

| Pair                                          | Likely contrast | Verdict          |
|-----------------------------------------------|-----------------|------------------|
| `oklch(0.15 0.01 H)` on `oklch(0.99 0.005 H)` | ~17:1           | ✅ AAA            |
| `oklch(0.55 0.01 H)` on `oklch(0.99 0.005 H)` | ~4.6:1          | ✅ AA body        |
| `oklch(0.65 0.01 H)` on `oklch(0.99 0.005 H)` | ~3.4:1          | ⚠️ large text only |
| `oklch(0.75 0.01 H)` on `oklch(0.99 0.005 H)` | ~2.5:1          | ❌ FAIL           |

**Test with real values:** use https://oklch.com/ or https://www.tpgi.com/color-contrast-checker/ before shipping.

## Focus Rings (Critical)

shadcn defaults to `ring-sky-500` or `ring-blue-500` — which collides with our color rules. Override globally:

```css
:root {
  --ring: oklch(0.55 0.15 250 / 0.5);  /* matches your accent at 50% */
}

*:focus-visible {
  outline: 2px solid var(--ring);
  outline-offset: 2px;
}
```

Use `:focus-visible` (not `:focus`) so mouse clicks don't show rings, but keyboard tab does.

For motion-friendly focus, use a 200ms ease transition on the outline width — don't animate the outline color.

## Keyboard Navigation Checklist

- [ ] Every clickable element is `<button>`, `<a>`, or has `role="button"` + `tabIndex={0}` + key handler
- [ ] Tab order matches visual order
- [ ] Modal traps focus inside until dismissed (use Radix or Headless UI)
- [ ] Esc closes modals, popovers, dropdowns
- [ ] Arrow keys navigate within radio groups, menus, tabs
- [ ] No keyboard trap (you can always Tab out)

## Semantic HTML

Don't use `<div>` for everything.

| Element        | Use for                                      |
|----------------|----------------------------------------------|
| `<button>`     | Triggers actions in-page                     |
| `<a href>`     | Navigation, opens new view/page              |
| `<nav>`        | Site navigation                              |
| `<main>`       | Primary page content (one per page)          |
| `<article>`    | Self-contained piece (blog post, product)    |
| `<section>`    | Thematic grouping                            |
| `<aside>`      | Tangential content (sidebar)                 |
| `<header>`     | Page or section intro                        |
| `<footer>`     | Page or section outro                        |
| `<h1>`–`<h6>`  | Sequential heading hierarchy (no skipping)   |
| `<dialog>`     | Modals (or Radix Dialog with proper roles)   |

## Screen Reader Hygiene

- **Images:** `alt` text describes purpose, not appearance. Decorative images get `alt=""`.
- **Icons in buttons:** wrap in `<span className="sr-only">Add to cart</span>` or use `aria-label`.
- **Form inputs:** ALWAYS associate with `<label htmlFor>` or `aria-labelledby`. Placeholders are NOT labels.
- **Loading states:** `aria-busy="true"` + `aria-live="polite"` on the parent.
- **Toasts / notifications:** `role="status"` + `aria-live="polite"` for non-urgent, `role="alert"` for urgent.

## Form Accessibility

- Label above input (mandatory — see layout.md)
- Helper text under input, linked via `aria-describedby`
- Error text under input, linked via `aria-describedby` AND `aria-invalid="true"`
- Required fields marked with `aria-required="true"` (and a visual indicator, not just color)
- Don't use color alone to indicate state — pair with icon or text

## Touch Targets

- Mobile interactive elements: **minimum 44×44px** tap area
- Pad small buttons with extra `padding` to reach 44px without growing visible size
- Spacing between adjacent tap targets: **at least 8px**

## Reduced Motion

Already covered in motion.md, but double-check:

```tsx
import { useReducedMotion } from 'framer-motion';
const reduced = useReducedMotion();
// Disable or shorten animations when reduced is true
```

## Common AI Accessibility Failures

- ❌ `<div onClick>` instead of `<button>`
- ❌ Placeholder used as the only label
- ❌ Skipped heading levels (`<h1>` then `<h3>`, no `<h2>`)
- ❌ `outline: none` on focus, no replacement
- ❌ Color-only error indication (red text, no icon, no label)
- ❌ `<a>` tags with no `href` (or `href="#"`)
- ❌ Modal that doesn't trap focus
- ❌ Animations that don't respect `prefers-reduced-motion`
- ❌ Insufficient contrast on muted text (`text-gray-400` on white = ~3:1, fails body)
- ❌ Touch targets under 44px on mobile

## Quick Audit Tools

Recommend the user run:

- **axe DevTools** browser extension — flags WCAG violations
- **Lighthouse** in Chrome DevTools — Accessibility score
- **WAVE** browser extension — visual feedback layer

## Pre-Flight Accessibility Check

- [ ] All body text contrast ≥ 4.5:1
- [ ] All interactive elements keyboard-reachable
- [ ] Focus rings visible (and not the default sky-blue)
- [ ] Heading levels sequential (no skipping)
- [ ] Form inputs have proper labels (not just placeholders)
- [ ] Errors aren't color-only
- [ ] Touch targets ≥ 44px
- [ ] Modals trap focus + Esc dismisses
- [ ] `prefers-reduced-motion` respected
- [ ] Decorative images have `alt=""`, meaningful images have descriptive alt
- [ ] Icon-only buttons have `aria-label` or `sr-only` text
