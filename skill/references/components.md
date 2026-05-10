# Component Library Reference

Don't build everything from scratch. Pull production-quality building blocks from these libraries — then customize so they don't look like default shadcn.

## The Three Libraries

### 1. React Bits — Animated components

**110+ components** — text animations, UI elements, animated backgrounds. Lightweight, tree-shakeable, copy-paste ready. Four variants: JS-CSS, JS-TW, TS-CSS, TS-TW.

#### When to use React Bits
- Animated text effects (text scramble, kinetic marquee, gradient stroke, blur reveal)
- Animated backgrounds (mesh gradients, particle fields, grid glow)
- Hover-aware components (parallax tilt, magnetic, holographic foil)
- Scroll-driven reveals

#### Install via shadcn

```bash
npx shadcn@latest add @react-bits/BlurText-TS-TW
npx shadcn@latest add @react-bits/SplitText-TS-TW
npx shadcn@latest add @react-bits/Aurora-TS-TW
npx shadcn@latest add @react-bits/MagicBento-TS-TW
```

#### React Bits Tools (free, browser-based)

- **Background Studio** — explore animated backgrounds, export as video/image/code
- **Shape Magic** — inner rounded corners, export as SVG / React / clip-path
- **Texture Lab** — 20+ effects (noise, dithering, ASCII), export high quality

Use these when designing background atmosphere or texture overlays.

### 2. 21st.dev Magic — Production components via MCP

100+ polished React components — buttons, navbars, hero sections, cards, footers — all pre-designed. Connected as an MCP server.

#### When to use 21st.dev
- Standard UI building blocks: navbar, footer, pricing, FAQ, testimonials
- Auth screens, settings pages, forms
- Marketing patterns: hero, features, CTA, social proof
- When you need "looks designed" but don't have time to design from scratch

#### Trigger from chat
After installing the MCP, just ask in plain English:

> "use 21st-dev magic to add a sticky navbar with a search command palette"

The MCP returns the component code. **Don't paste it raw** — apply your project's color tokens, font tokens, and motion patterns before committing.

#### Install (MCP setup in `~/.claude.json`)

```json
"21st-dev-magic": {
  "command": "npx",
  "args": ["-y", "@21st-dev/magic@latest"],
  "env": { "API_KEY": "YOUR_KEY_FROM_21ST_DEV_CONSOLE" }
}
```

Get the API key at https://21st.dev/magic/console (free tier exists).

### 3. shadcn/ui — The structural primitives

The base layer for forms, dialogs, dropdowns, tables. **Never use defaults.** Always customize:

- **Radii:** Default `rounded-md` is dead. Use `rounded-[14px]` or `rounded-[2.5rem]`.
- **Colors:** Override CSS variables in `globals.css` to match your project palette.
- **Shadows:** Replace shadcn's default `shadow-md` with tinted diffusion shadows.
- **Motion:** Wrap dialogs/popovers in Framer Motion variants.

#### Install

```bash
npx shadcn@latest init
npx shadcn@latest add button input dialog dropdown-menu
```

## Decision Tree

| Need                                     | Use                  |
|------------------------------------------|----------------------|
| Hero text with kinetic effect            | React Bits           |
| Animated background atmosphere           | React Bits           |
| Standard navbar / pricing / hero layout  | 21st.dev Magic       |
| Form field, dialog, dropdown, table      | shadcn (customized)  |
| Bento grid feature section               | Build from scratch (see `bento-engine.md`) |
| Marketing hero (split / asymmetric)      | Build from scratch (see `layout.md`) |
| Feature row with motion                  | Build from scratch + React Bits accents |

## Customization Checklist (Before Shipping ANY Library Component)

- [ ] Replaced default radii with project's chosen radius
- [ ] Replaced default colors with project's CSS variables
- [ ] Replaced default fonts with project's font stack
- [ ] Replaced default shadows with tinted versions
- [ ] Wrapped interactive parts in spring-physics motion
- [ ] Removed any default `Inter`, `Roboto`, or system font references
- [ ] Removed default purple/blue accent colors
- [ ] Verified mobile collapse works
- [ ] Verified empty / loading / error states exist

## Anti-Patterns

- ❌ Using default shadcn unmodified (looks like every other shadcn site)
- ❌ Pasting 21st.dev components without retokenizing colors/fonts
- ❌ Mixing 5+ component libraries in one project (visual chaos)
- ❌ Pulling React Bits backgrounds AND complex Framer animations on the same screen (motion overload)
- ❌ Using component library defaults when the brief was "premium / distinctive"

## Recommended Stack Per Project Type

| Project type        | shadcn  | 21st.dev | React Bits | Custom % |
|---------------------|---------|----------|------------|----------|
| SaaS landing        | ✓       | ✓ (nav, pricing) | ✓ (text fx) | 40%      |
| Analytics dashboard | ✓       | ✓ (settings, table) | — | 60%      |
| Portfolio           | —       | —        | ✓ heavy    | 80%      |
| E-commerce          | ✓       | ✓ (cards, cart) | — | 50%      |
| Editorial / blog    | ✓ minimal| —       | ✓ text fx  | 70%      |
| Music festival poster| —       | —        | ✓ heavy    | 90%      |
