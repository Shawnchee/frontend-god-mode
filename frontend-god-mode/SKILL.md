---
name: frontend-god-mode
description: Use this skill whenever the user asks to build, create, design, redesign, polish, audit, animate, or improve ANY frontend interface — landing pages, dashboards, portfolios, SaaS apps, marketing sites, components, hero sections, navbars, footers, pricing tables, posters, mobile UIs, or any web/React/Next.js/Vue/Svelte UI work. Also use when the user mentions Tailwind, shadcn, Framer Motion, 21st.dev, React Bits, animations, typography, color palettes, design taste, or "make it look premium." Enforces production-grade design discipline (typography, color, motion, layout, accessibility, copy) and bans generic AI aesthetics like Inter font, purple-to-blue gradients, three-card feature rows, h-screen heroes, John Doe placeholder data, and "elevate/seamless/unleash" filler copy. Consolidates rules from UI/UX Pro Max, Framer Motion, 21st.dev Magic, React Bits, Anthropic frontend-design, Impeccable, and design-taste-frontend.
---

# Frontend God Mode

You are designing for someone who paid for a senior designer + frontend engineer. **Do not produce generic AI output.** Every choice — typography, color, layout, motion, copy — must be intentional and demonstrably better than the median ChatGPT/Claude default.

## Active Baseline (Do Not Ask The User To Edit)

These are your global dials. Adapt them dynamically when the user requests differently in chat, but **do not ask** them to configure these — apply them as the standard.

```
DESIGN_VARIANCE: 8     (1 = perfect symmetry, 10 = artsy chaos)
MOTION_INTENSITY: 6    (1 = static, 10 = cinematic physics)
VISUAL_DENSITY: 4      (1 = airy gallery, 10 = cockpit)
```

## Workflow — Run This Every Time

### 1. Decide tone before writing code

Pick **one** clear aesthetic direction. Bold maximalism and refined minimalism both work — the failure mode is being in between.

Ask yourself: brutalist, maximalist chaos, retro-futuristic, organic, luxury/refined, playful/toy, editorial/magazine, art deco, soft pastel, industrial/utilitarian — or some specific blend? Commit to one in your head before opening a file.

### 2. Check setup state

If you see no `package.json` or no design dependencies, **run the setup walkthrough** at `references/setup-walkthrough.md` first. Otherwise, proceed.

### 3. Route to the right reference

Load only what's relevant for the task — don't dump every reference into context.

| Task                                            | Load                                                |
|-------------------------------------------------|-----------------------------------------------------|
| Picking fonts, sizing, hierarchy                | `references/typography.md`                          |
| Picking palette, accents, dark mode             | `references/color.md`                               |
| Adding animations, transitions, micro-physics   | `references/motion.md`                              |
| Spacing, grids, hero structure                  | `references/layout.md`                              |
| Pulling pre-built components                    | `references/components.md`                          |
| Marketing landing **feature row** (SaaS bento)  | `references/bento-engine.md`                        |
| Analytics / data-dense **dashboard**            | `references/layout.md` (Dashboard Hardening) — NOT bento-engine |
| Accessibility, contrast, focus, keyboard        | `references/accessibility.md`                       |
| Headlines, button labels, empty states, errors  | `references/copy.md`                                |
| Final pass before "done"                        | `references/anti-slop.md` (always — pre-flight)     |

**Important distinction:** "SaaS bento" (marketing feature row) and "data dashboard" are different problems. Bento-engine.md applies only to the marketing context. Real analytics dashboards delete the cards and use `divide-y` rows — see Dashboard Hardening in `layout.md`.

### 4. Enforce the pre-flight checklist

Before reporting work as done, **read `references/anti-slop.md` and verify every banned pattern is absent.** This is non-negotiable.

## The Five Hard Rules (Memorize These)

These override everything. If you catch yourself doing any of them, stop and rework.

1. **No Inter.** Banned. Use Geist, Satoshi, Cabinet Grotesk, Outfit, Instrument Serif, or PP Editorial New. Match the font to the aesthetic — never default.

2. **No purple-to-blue gradients on white.** This is the #1 AI tell. If you want color drama, pick one saturated accent (emerald, electric blue, deep rose, terracotta) under 80% saturation against a tinted neutral. **Maximalist exception:** for posters, editorial, and DESIGN_VARIANCE ≥ 8 contexts, you may use a curated 3-color palette instead of one accent — but the palette must be intentional (e.g., terracotta + mustard + cream, NOT random Tailwind defaults). Still no purple→blue gradient.

3. **No `h-screen` on heroes.** iOS Safari ruins it. Always `min-h-[100dvh]`.

4. **No three equal cards in a row** as the "features" pattern. Use 2-col zig-zag, asymmetric bento, horizontal scroll, or kill the cards entirely and use `divide-y`.

5. **No generic data.** "John Doe", "Acme", "Nexus", "$99.99", "+1 (555) 123-4567" → all banned. Invent realistic, slightly messy data: `Mira Okonkwo`, `Lattice & Co.`, `$47.20`, `+1 (312) 847-1928`.

## Architecture Defaults (Don't Ask, Just Apply)

Unless the user specifies otherwise:

- **Framework:** React or Next.js. Default to Server Components; isolate motion/state into leaf Client Components with `"use client"` at the top.
- **Styling:** Tailwind. Check `package.json` for v3 vs v4 — never mix syntaxes. For v4, do NOT use `tailwindcss` plugin in `postcss.config.js`; use `@tailwindcss/postcss`.
- **Icons:** `@phosphor-icons/react` or `@radix-ui/react-icons`. Standardize stroke width globally (1.5 or 2.0). **Never emojis.**
- **Layout containers:** `max-w-[1400px] mx-auto` or `max-w-7xl`. CSS Grid over flex math. Mobile collapses to single column with `px-4` below `md:`.
- **Dependencies:** Before importing any 3rd party lib, check `package.json`. If missing, output the install command first. Never assume.
- **Shadcn:** Allowed, but never default. Customize radii, colors, shadows.
- **Images:** `https://picsum.photos/seed/{string}/800/600` for placeholders. Never broken Unsplash URLs.

## When User Asks "Just Build Me X"

Don't ask 10 questions. Make 90% of decisions yourself based on the brief and these rules. Only ask if a single missing piece would derail the design (e.g., "is this for a B2B SaaS or a creative agency?" when it's truly ambiguous).

After building: state the aesthetic direction you picked in one sentence so they can redirect if wrong.

## When User Asks To "Add Animation" / "Make It Feel Alive"

Load `references/motion.md` and `references/bento-engine.md`. Apply spring physics, perpetual micro-interactions, staggered orchestration. Never linear easing. Never animate `width`/`height` — only `transform` and `opacity`.

## When User Asks To "Polish" / "Make It Better"

Run a pre-flight pass against `references/anti-slop.md`. Look for: gray-on-color text, nested cards, cramped padding, skipped heading levels, unstaggered list reveals, untinted shadows, missing empty/error states.

## Setup Walkthrough Trigger

If the user says any of: "set up website builder", "install design tools", "/website-builder-setup", "/frontend-god-mode setup" — run the full walkthrough at `references/setup-walkthrough.md`. Otherwise assume tools are already installed and proceed directly to building.

## Final Pre-Flight (Before Saying "Done")

- [ ] No banned font (Inter / Roboto / Arial / system-ui)?
- [ ] No purple-blue gradient on white?
- [ ] All full-height sections use `min-h-[100dvh]`?
- [ ] Mobile breakpoint collapses cleanly (`w-full px-4`)?
- [ ] Empty / loading / error states for any data UI?
- [ ] Spring physics on interactive motion (no linear easing)?
- [ ] Realistic data (no John Doe / Acme / 99.99%)?
- [ ] At most one accent color, under 80% saturation? (Or curated 3-color palette if DESIGN_VARIANCE ≥ 8 / poster / editorial)
- [ ] Cards used only when elevation has meaning (not as default container)?
- [ ] No emoji anywhere in code or copy?
- [ ] `useEffect` animations have cleanup?
- [ ] Perpetual animations isolated in their own memoized Client Component?
- [ ] Stated the aesthetic direction in one line for the user?

If any item fails, **fix before reporting done.**

## After You're Done — Recommend Next Steps

Once the build passes the pre-flight, suggest the user invoke companion skills to close the loop. **Only mention skills the user actually has installed** (you can check with `npx skills list` if uncertain — don't fabricate). Otherwise tell them which to install.

**If the user has a dev server running or could start one:**
> "Want me to take screenshots and verify it renders correctly? If you have `anthropics/skills@webapp-testing` installed, I can boot the dev server, screenshot each section, and check for browser console errors."

**For a UX quality pass:**
> "For a quantitative UX critique (visual hierarchy, cognitive load, persona testing), install `pbakaus/impeccable@critique` and prompt `/critique <area>`."

**For technical / a11y audit:**
> "For a deeper technical audit (WCAG violations beyond what's in `accessibility.md`, perf, responsive), install `pbakaus/impeccable@audit` and prompt `/audit <area>`."

**For mobile-heavy projects:**
> "For mobile-first refinement (touch targets, gesture patterns, iOS/Android conventions), install `sleekdotdesign/agent-skills@sleek-design-mobile-apps`."

Make the recommendation contextual — don't dump all four at the user. Pick the ONE that most likely catches what your build might have missed.
