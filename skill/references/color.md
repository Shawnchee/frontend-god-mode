# Color & Contrast Reference

Color is where the average AI design dies. Default purple gradients on white, washed-out grays, oversaturated CTAs — every one is a tell. This reference replaces those defaults with calibrated, intentional choices.

## The Core Rule

**Maximum ONE accent color. Saturation under 80%.**

Two accents = visual noise. Three = chaos. Pick one and let neutrals carry the rest.

### Exception: Maximalist / Editorial / Poster contexts

When the project type is a poster, music/festival/event design, editorial layout, or DESIGN_VARIANCE is ≥ 8 (artsy / chaotic), you may use a **curated 3-color palette** instead of one accent. Rules for this exception:

- The palette must be intentional and named (e.g., "70s warm: terracotta + mustard + cream + charcoal text")
- One color is still dominant (~50%), one is secondary (~30%), one is accent (~15%), neutral text (~5%)
- Never random Tailwind defaults — pick the OKLCH values intentionally
- Still no purple→blue gradient. That ban is absolute.

Default behavior remains: ONE accent. Only relax for genuine maximalist contexts.

## The Forbidden Palettes

These scream "AI generated":

- **Purple → blue gradient on white.** The single biggest tell. Banned.
- **Pure black `#000000` on pure white `#FFFFFF`.** Use Zinc-950 / Off-Black on Zinc-50 / Off-White.
- **Pastel purple + lavender + lilac combos** ("the lila cliché"). Banned.
- **Neon green / electric purple as primary.** Use as 1px accent only.
- **Gray text on a colored background.** Always tint gray with the background hue.
- **`bg-gray-100` everywhere as the default neutral.** Use Zinc, Slate, Stone, or Neutral instead — and stay consistent.

## Approved Foundations

### Tinted neutrals — pick ONE family per project

- **Zinc** — coolest, most neutral, works for premium SaaS
- **Slate** — slight blue undertone, works for tech
- **Stone** — slight warm undertone, works for editorial / luxury
- **Neutral** — true gray, works for brutalist / industrial

**Never mix families** within a project. If you start with Zinc, finish with Zinc.

### Accent colors that don't suck

Pick ONE per project. All should be desaturated to ~70-80% from their pure form:

- **Emerald** (`#059669` / `oklch(0.65 0.15 150)`)
- **Electric blue** (`#0066FF` desaturated to `#1E5FCC` / `oklch(0.55 0.18 250)`)
- **Deep rose** (`#E11D48` desaturated to `#BE3554` / `oklch(0.55 0.18 10)`)
- **Terracotta** (`#C45A3A` / `oklch(0.55 0.13 35)`)
- **Mustard** (`#CA8A04` / `oklch(0.65 0.13 75)`)
- **Aubergine** (`#5B2A86` desaturated / `oklch(0.35 0.12 300)`)

## OKLCH Over HSL

Use OKLCH for color definition. It produces perceptually uniform colors and predictable adjustments.

```css
:root {
  --bg: oklch(0.99 0.005 60);          /* off-white, warm tint */
  --fg: oklch(0.15 0.01 60);           /* off-black, matched tint */
  --muted: oklch(0.55 0.01 60);        /* matched neutral */
  --accent: oklch(0.55 0.15 150);      /* singular emerald */
  --border: oklch(0.92 0.005 60);
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg: oklch(0.12 0.005 60);
    --fg: oklch(0.98 0.005 60);
    --muted: oklch(0.65 0.01 60);
    --accent: oklch(0.65 0.15 150);
    --border: oklch(0.22 0.005 60);
  }
}
```

## Tinted Shadows

Default `box-shadow: 0 0 black` is dead. Tint shadows toward the background hue.

```css
/* Bad */
.card { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

/* Good — tinted toward warm bg */
.card { box-shadow: 0 4px 12px oklch(0.4 0.02 60 / 0.08); }

/* Diffusion shadow for premium feel */
.card { box-shadow: 0 20px 40px -15px oklch(0.2 0.02 60 / 0.05); }
```

## Color in Dark Mode

- **Don't use pure black backgrounds.** Use `oklch(0.12 0.005 H)` where H matches your hue family.
- **Borders need to lift.** `oklch(0.22 0.005 H)` is your `border` token in dark mode.
- **Accents need MORE saturation in dark mode.** Bump to `oklch(0.7 0.18 H)`.
- **Avoid white-on-black.** Use `oklch(0.95 0.005 H)` to match background tint.

## Status Colors

- **Success:** Emerald `oklch(0.6 0.14 150)` — never lime
- **Warning:** Amber `oklch(0.7 0.15 75)` — never yellow
- **Error:** Rose `oklch(0.55 0.18 10)` — never pure red
- **Info:** Sky `oklch(0.6 0.12 230)` — never neon blue

## Anti-Slop Color Audit

Run through this before shipping:

- [ ] Is there a purple-blue gradient? Remove it.
- [ ] Is `#000` or `#FFF` used directly? Replace with tinted neutrals.
- [ ] Is gray text on a colored background? Tint the gray.
- [ ] Is the accent color used more than 3 times per screen? Reduce.
- [ ] Are shadows untinted? Add hue.
- [ ] Is success/error using the wrong palette family? Realign.
- [ ] Are borders pure gray? Tint to match background.
- [ ] Saturation under 80% on the primary accent?

## Examples By Aesthetic

| Aesthetic        | Bg              | Fg              | Accent         |
|------------------|-----------------|-----------------|----------------|
| Premium SaaS     | Zinc 50         | Zinc 950        | Emerald 600    |
| Brutalist        | White           | Black           | Electric Blue  |
| Luxury           | Stone 50        | Stone 950       | Aubergine      |
| Editorial        | Cream `#F5F1E8` | Charcoal        | Deep Rose      |
| Retro-futuristic | Black           | Off-white       | Mustard        |
| Industrial       | Neutral 100     | Neutral 900     | Terracotta     |
