# DESIGN.md — Persistent Design System

When you finish a build (or a meaningful chunk of one), write or update a `DESIGN.md` at the project root. This is the project's persistent design memory: aesthetic direction, tokens, motion config, component inventory.

**Why this matters:** without DESIGN.md, every Claude session re-decides the design from scratch. Three sessions later, your fonts drift, your accent color shifts, your motion feels different. DESIGN.md prevents drift.

## When to write/update DESIGN.md

- **First build:** create it. Establish the aesthetic + tokens.
- **Subsequent builds in the same project:** read it FIRST, follow it, only update if a deliberate evolution.
- **User says "this is different from last time":** treat that as a bug and re-align with DESIGN.md.

## Where to put it

Project root: `./DESIGN.md`. Same level as `package.json`. Always there. Don't bury it in `/docs`.

## The template

Copy this verbatim, fill in the project's actual choices:

```markdown
# Design

> Auto-generated and maintained by frontend-god-mode.
> Source of truth for typography, color, motion, layout, and component tokens.
> Read this BEFORE touching the UI in any subsequent session.

## Aesthetic direction

One sentence describing the vibe.
e.g. "Premium SaaS — operational, engineer-trusted, Vercel-core meets terminal."
e.g. "Editorial luxury — typographer's portfolio, italic serif eyebrows, generous whitespace."
e.g. "70s retro maximalist — warm palette, broken grid, tactile texture overlay."

## Dials

- DESIGN_VARIANCE: 8 / 10  (1 = perfect symmetry, 10 = artsy chaos)
- MOTION_INTENSITY:  6 / 10  (1 = static, 10 = cinematic physics)
- VISUAL_DENSITY:    4 / 10  (1 = airy gallery, 10 = cockpit)

## Type stack

- Display: Geist (variable, weights 400-700)
- Body: Geist
- Mono: Geist Mono
- Loaded via: `next/font/google`
- Optical features enabled: `font-feature-settings: "ss01", "cv11"`

Banned in this project: Inter, Roboto, Arial, system-ui, serif on dashboards.

## Color tokens (OKLCH)

```css
:root {
  --bg:      oklch(0.12 0.005 250);   /* off-black, cool tint */
  --fg:      oklch(0.98 0.005 250);   /* off-white */
  --muted:   oklch(0.65 0.01 250);    /* tinted gray */
  --border:  oklch(0.22 0.005 250);
  --accent:  oklch(0.65 0.18 80);     /* amber */
  --success: oklch(0.6 0.14 150);     /* emerald */
  --error:   oklch(0.55 0.18 10);     /* rose */
}
```

Banned in this project:
- Pure #000 / #FFF (use tinted neutrals above)
- Purple-to-blue gradients (the AI tell)
- More than ONE accent (or 3 max in maximalist mode — see DESIGN_VARIANCE)

## Shadows

```css
--shadow-warm-lift: 0 1px 0 rgba(255,255,255,0.04) inset,
                    0 0 0 1px rgba(251,191,36,0.06),
                    0 30px 80px -30px rgba(8,6,2,0.8);
```

Always tint shadows toward bg hue. No pure-black drops.

## Motion

- Default spring: `{ type: "spring", stiffness: 100, damping: 20 }`
- Tap spring: `{ stiffness: 400, damping: 30 }`
- Hero spring: `{ stiffness: 60, damping: 18 }`
- Stagger: `0.08s` between children, `0.1s` initial delay
- Easing fallback (CSS): `cubic-bezier(0.16, 1, 0.3, 1)`
- Banned: linear easing, bounce/elastic, animating width/height

Library: framer-motion@12.x (or motion/react if migrated)

## Layout

- Container: `max-w-[1400px] mx-auto px-6 md:px-10`
- Reading width: `max-w-[65ch]`
- Section padding: `py-16 md:py-24` (daily density) / `py-24 md:py-32` (airy)
- Hero pattern: split-screen 60/40 (left text, right asset) — NOT centered
- Feature row: bento, asymmetric col/row spans — NEVER 3 equal cards
- Mobile: collapse all `grid-cols-N` to `grid-cols-1` below `md:`

## Component inventory

shadcn: Button, Card, Dialog, DropdownMenu, Input
21st.dev: navbar pattern, pricing pattern (customized to tokens above)
React Bits: Aurora background (hero only), BlurText (case-study reveals)
Custom: LogViewer mockup, BentoCard, MetricRow

## Project-specific bans

- No 99.99% / round-number stats (use messy: 99.987%)
- No "Acme" / "Nexus" / "John Doe" placeholder data
- No emojis (Phosphor icons only, stroke 1.5)
- No `h-screen` (always `min-h-[100dvh]`)

## Brand voice (copy)

- Tone: direct, technical, slightly dry — not chirpy
- Banned: elevate, seamless, unleash, next-gen, game-changing
- Headline pattern: specific outcome with a number ("Search a billion log lines in under 200 ms")
- Button labels: specific verbs ("Send invoice" not "Submit")

## Accessibility floor

- WCAG 2.2 AA contrast on all body copy (≥ 4.5:1)
- Focus-visible rings on every interactive element
- `prefers-reduced-motion` respected
- 44×44px minimum touch targets on mobile

## Last updated

YYYY-MM-DD by [session description, e.g. "added pricing teaser"]
```

## Authoring rules

1. **Be specific.** "Geist" not "modern sans-serif." OKLCH values not "neutral gray."
2. **List bans inline** so any reader (human or AI) sees them immediately.
3. **Keep it ONE file.** Don't split into design/typography.md, design/color.md. One file is the point.
4. **Append to "Last updated"** every time you touch it, with a one-line description of what changed.
5. **Read it BEFORE building** in any subsequent session. Quote from it when explaining decisions.

## What NOT to put in DESIGN.md

- Marketing copy (lives in `/content` or actual pages)
- API contracts (lives in `/docs/api`)
- Long rationales for why a choice was made (one line is enough — "amber chosen for warmth against zinc")
- Anti-patterns from the global skill (those are in `references/anti-slop.md`, not project-specific)

## Anti-drift contract

If a future Claude session generates UI that violates DESIGN.md, the user can say:

> "this doesn't match DESIGN.md"

And Claude must:
1. Re-read DESIGN.md
2. Identify the specific token/rule that was violated
3. Fix the violation (don't update DESIGN.md to match the bad output)

DESIGN.md is the source of truth, not a rough guideline.
