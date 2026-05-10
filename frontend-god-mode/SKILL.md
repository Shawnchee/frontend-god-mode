---
name: frontend-god-mode
description: Use this skill whenever the user asks to build, create, design, redesign, polish, audit, animate, improve, fix, or "make prettier/cleaner/nicer" ANY frontend interface — landing pages, dashboards, portfolios, SaaS apps, marketing sites, components, hero sections, navbars, footers, pricing tables, posters, mobile UIs, or any web/React/Next.js/Vue/Svelte UI work. Also use when the user mentions Tailwind, shadcn, Framer Motion, 21st.dev, React Bits, animations, typography, color palettes, design taste, "make it look premium," "fix the look," or "make this less generic." Enforces production-grade design discipline (typography, color, motion, layout, accessibility, copy) and bans generic AI aesthetics like Inter font, purple-to-blue gradients, three-card feature rows, h-screen heroes, John Doe placeholder data, and "elevate/seamless/unleash" filler copy. Generates a project DESIGN.md to lock in tokens across sessions. Consolidates rules from UI/UX Pro Max, Framer Motion, 21st.dev Magic, React Bits, Anthropic frontend-design, Impeccable, and design-taste-frontend.
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

If you see no `package.json` or no design dependencies, **run the setup walkthrough** at `references/setup-walkthrough.md` first.

**Then check for `DESIGN.md` at the project root.** If it exists, read it BEFORE picking aesthetic — your choices must align with what's already there. If it doesn't exist and you're about to do meaningful UI work, plan to create it (see `references/design-doc.md` and step 5 below).

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
| Generating / updating the project's DESIGN.md   | `references/design-doc.md`                          |
| Final pass before "done"                        | `references/anti-slop.md` (always — pre-flight)     |

**Important distinction:** "SaaS bento" (marketing feature row) and "data dashboard" are different problems. Bento-engine.md applies only to the marketing context. Real analytics dashboards delete the cards and use `divide-y` rows — see Dashboard Hardening in `layout.md`.

### 4. Enforce the pre-flight checklist

Before reporting work as done, **read `references/anti-slop.md` and verify every banned pattern is absent.** This is non-negotiable.

### 5. Write or update DESIGN.md at the project root

After finishing a meaningful build, write `./DESIGN.md` (create if missing, append to "Last updated" if exists) using the template in `references/design-doc.md`. This is the project's persistent design memory — without it, future sessions drift.

**Skip this step only when:** the user is making a tiny, isolated tweak (e.g., "fix this button label") that doesn't change tokens or aesthetic.

## The Five Hard Rules (Memorize These)

These override everything. If you catch yourself doing any of them, stop and rework.

1. **No regular Inter.** Banned. Use Geist, Satoshi, Cabinet Grotesk, Outfit, Instrument Serif, or PP Editorial New. Match the font to the aesthetic — never default. (`Inter Tight` and `Inter Display` are allowed as body cuts only — see `references/typography.md`.)

2. **No purple-to-blue gradients on white.** This is the #1 AI tell. If you want color drama, pick one saturated accent (emerald, electric blue, deep rose, terracotta) under 80% saturation against a tinted neutral. **Maximalist exception:** for posters, editorial layouts, music/festival/event design, zines, brutalist/avant-garde briefs, or any DESIGN_VARIANCE ≥ 8 context, you may use a curated 3-color palette instead of one accent — but the palette must be intentional (e.g., terracotta + mustard + cream, NOT random Tailwind defaults). Still no purple→blue gradient. When in doubt, default to ONE accent.

3. **No `h-screen` on heroes.** iOS Safari ruins it. Always `min-h-[100dvh]`.

4. **No three equal cards in a row** as the "features" pattern. Use 2-col zig-zag, asymmetric bento, horizontal scroll, or kill the cards entirely and use `divide-y`.

5. **No generic data.** "John Doe", "Acme", "Nexus", "$99.99", "+1 (555) 123-4567" → all banned. Invent realistic, slightly messy data: `Mira Okonkwo`, `Lattice & Co.`, `$47.20`, `+1 (312) 847-1928`.

6. **DESIGN.md is mandatory.** On any meaningful UI build, read `./DESIGN.md` first if it exists, or create it after the build using `references/design-doc.md` as the template. Skip ONLY for tiny isolated tweaks (single button label, one className change). Never skip on first-time builds.

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

Run the full pre-flight from `references/anti-slop.md` plus the items below. The full anti-slop checklist is the source of truth — this is the must-not-skip subset.

**Typography**
- [ ] No regular Inter / Roboto / Arial / system-ui as primary
- [ ] At most TWO type families (display + body, optional mono)
- [ ] Body line-height ≥ 1.5
- [ ] Body width capped at `max-w-[65ch]`

**Color**
- [ ] No purple-blue gradient on white
- [ ] No `#000` / `#FFF` directly (tinted neutrals only)
- [ ] One accent (or curated 3-color palette in maximalist mode)
- [ ] Tinted shadows (no pure black)

**Layout**
- [ ] No centered hero (when DESIGN_VARIANCE > 4)
- [ ] No 3 equal cards in a row as features
- [ ] No nested cards beyond depth 1
- [ ] All full-height sections use `min-h-[100dvh]` (never `h-screen`)
- [ ] Mobile collapses to single column with `px-4` minimum

**Motion**
- [ ] Spring physics on interactive motion (no linear easing for UI motion)
- [ ] No bounce / elastic
- [ ] Only `transform`/`opacity` animated
- [ ] Perpetual loops isolated in memoized leaf Client Components
- [ ] `useEffect` animations have cleanup
- [ ] `prefers-reduced-motion` respected

**Accessibility**
- [ ] Body text contrast ≥ 4.5:1 (WCAG AA)
- [ ] Focus-visible rings on every interactive element
- [ ] Touch targets ≥ 44px on mobile
- [ ] Form inputs have real labels (not just placeholders)
- [ ] Heading levels sequential (no skipping)

**Content & state**
- [ ] Realistic data (no John Doe / Acme / 99.99%)
- [ ] No filler copy (Elevate / Unleash / Seamless / Next-Gen)
- [ ] No emojis anywhere (Phosphor / Radix icons only)
- [ ] Loading skeletons match layout (not generic spinners)
- [ ] Empty + error states designed and inline

**Skill protocol**
- [ ] Stated the aesthetic direction in one line for the user
- [ ] DESIGN.md written/updated at the project root (mandatory unless tiny isolated tweak)
- [ ] DESIGN.md was read FIRST if it already existed

If any item fails, **fix before reporting done.**

## After You're Done — Recommend Next Steps

Once the build passes the pre-flight, suggest the user invoke companion skills to close the loop. **Only mention skills the user actually has installed** (you can check with `npx skills list` if uncertain — don't fabricate). Otherwise tell them which to install.

**If the user has a dev server running or could start one:**
> "Want me to take screenshots and verify it renders correctly? Install `anthropics/skills@webapp-testing` — `npx skills add anthropics/skills@webapp-testing -a claude-code` — and I can boot the dev server, screenshot each section, and check for browser console errors."

**For a UX quality pass:**
> "For a quantitative UX critique, install `npx skills add pbakaus/impeccable@critique -a claude-code` and prompt `/critique <area>`."

**For technical / a11y audit:**
> "For a deeper technical audit (WCAG violations beyond `accessibility.md`, perf, responsive), install `npx skills add pbakaus/impeccable@audit -a claude-code` and prompt `/audit <area>`."

**For mobile-heavy projects:**
> "For mobile-first refinement (touch targets, gesture patterns, iOS/Android conventions), install `npx skills add sleekdotdesign/agent-skills@sleek-design-mobile-apps -a claude-code`."

Make the recommendation contextual — don't dump all four at the user. Pick the ONE that most likely catches what your build might have missed.
