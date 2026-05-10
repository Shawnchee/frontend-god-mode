# Anti-Slop Reference (Pre-Flight Mandatory)

This is the final filter. Run the project through every item before reporting "done." If any check fails, fix it. No exceptions.

## The 24 AI Tells

If your output has any of these, it screams "AI generated."

### Visual / CSS
1. **Inter font** for premium / creative work (use Geist, Satoshi, Cabinet Grotesk, Outfit, PP Editorial New)
2. **Purple-to-blue gradient** on white backgrounds (the #1 tell — banned outright)
3. **Pure `#000` / `#FFF`** without tint (use `oklch(0.12 0.005 H)` / `oklch(0.99 0.005 H)`)
4. **Default neon shadow** like `box-shadow: 0 0 20px rgba(120,80,255,0.5)` (banned)
5. **Untinted shadows** with pure black (`rgba(0,0,0,0.1)`) — must tint to bg hue
6. **Gradient text fill** on large H1s (cliché, use solid color + tracking)
7. **Custom mouse cursors** (outdated, breaks accessibility — banned)
8. **Side-tab borders** (`border-l-4 border-purple-500` on alerts) — banned
9. **Bounce / elastic easing** (feels dated, use spring with `damping: 20`)
10. **Generic `rounded-md`** everywhere — vary based on aesthetic (`rounded-[2.5rem]`, `rounded-[14px]`, sharp `rounded-none`)

### Typography
11. **Oversized H1 that screams** — control with weight + color, not just `text-9xl`
12. **Serif fonts on dashboards** — banned for software UIs
13. **All-caps body copy** (only labels < 4 words)
14. **Centered long paragraphs** — left-align everything past 2 lines
15. **Body width over 65 characters** — caps reading comfort
16. **`font-sans` defaulting to system-ui** — must explicitly load a non-system font

### Layout
17. **Centered hero** with H1 + subtitle + 2 CTAs (banned when DESIGN_VARIANCE > 4)
18. **3 equal cards in a row** as the features pattern (banned)
19. **Cards inside cards** — flatten the depth
20. **`h-screen` on heroes** — `min-h-[100dvh]` always
21. **Flex percentage math** (`w-[calc(33%-1rem)]`) — use Grid

### Content / Data
22. **Generic names** — "John Doe", "Jane Smith", "Sarah Chen", "Jack Su" (banned). Use specific, realistic names: `Mira Okonkwo`, `Theo Vasquez`, `Lin Park-Aboagye`
23. **Round-number fake data** — `99.99%`, `$50.00`, `1,000 users`, `+1 (555) 123-4567` (banned). Use messy: `47.2%`, `$47.20`, `1,128 users`, `+1 (312) 847-1928`
24. **Startup slop names** — "Acme", "Nexus", "SmartFlow", "Apex" (banned). Invent contextual: `Lattice & Co.`, `Provenance Studio`, `Tessellate Labs`

### Copy
- **Filler words:** "Elevate", "Seamless", "Unleash", "Next-Gen", "Revolutionary", "Game-Changing" — all banned. Use concrete verbs.
- **"Lorem ipsum"** in shipped output — banned. Write actual placeholder copy that matches the aesthetic.
- **AI-tone phrases:** "In the realm of...", "Whether you're...", "From X to Y" — banned.

### Images
- **Broken Unsplash links** — banned. Use `https://picsum.photos/seed/{string}/800/600` for deterministic placeholders, or specific stock URLs you've verified.
- **Generic SVG "egg" avatars** or Lucide user icons as user profile pics — banned. Use named, varied placeholder portraits or stylized initials.
- **Emojis** anywhere — banned. Use Phosphor Icons or Radix Icons.

## Forbidden CSS Patterns

```css
/* ❌ All banned */
.bad-1 { font-family: Inter, sans-serif; }
.bad-2 { background: linear-gradient(135deg, #a855f7, #3b82f6); }
.bad-3 { color: #000; background: #fff; }
.bad-4 { box-shadow: 0 0 30px rgba(168, 85, 247, 0.4); }
.bad-5 { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
.bad-6 { animation: bounce 1s infinite; }
.bad-7 { cursor: url('custom.png'), auto; }
.bad-8 { border-left: 4px solid purple; }
.bad-9 { transition: all 0.3s ease; }  /* use cubic-bezier */
.bad-10 { height: 100vh; }  /* use 100dvh */
```

## Forbidden React Patterns

```tsx
/* ❌ Banned */
const [mouseX, setMouseX] = useState(0);  // re-renders kill mobile — use useMotionValue

<div className="grid grid-cols-3 gap-4">  // banned for "features" sections
  <Card />
  <Card />
  <Card />
</div>

<motion.div animate={{ width: '100%' }} />  // animate transform/opacity only

window.addEventListener('scroll', ...)  // use useScroll
```

## State Coverage Required

Every data-displaying component MUST have:

- ✅ **Loading state** — skeleton matching layout sizes (NOT generic spinners)
- ✅ **Empty state** — beautifully composed, indicates how to populate
- ✅ **Error state** — clear, inline, actionable
- ✅ **Success state** — feedback after mutations

Generic AI output skips empty/error states. **Don't.**

## Architecture Verifications

- [ ] No `'use client'` on Server Components that could be RSC
- [ ] All Framer Motion components have `'use client'` at top
- [ ] Tailwind v3 vs v4 syntax matches `package.json`
- [ ] `package.json` checked before importing any 3rd party lib
- [ ] No `useEffect` without cleanup
- [ ] No animations on `width`/`height`
- [ ] Memoized perpetual-motion components
- [ ] No mixing GSAP + Framer in same component tree

## The Final Pre-Flight (Read Before Saying "Done")

```
TYPOGRAPHY
[ ] No Inter / Roboto / Arial / system-ui as primary
[ ] Two type families maximum (display + body, optional mono)
[ ] Body line-height ≥ 1.5
[ ] Body width capped at 65ch
[ ] Display tracking tightened

COLOR
[ ] No purple-blue gradient on white
[ ] No #000 / #FFF directly (tinted only)
[ ] One accent color, saturation ≤ 80%
[ ] Tinted shadows (no pure black)
[ ] Status colors from approved palette

LAYOUT
[ ] No centered hero (variance > 4)
[ ] No 3 equal cards row
[ ] No nested cards beyond depth 1
[ ] No h-screen
[ ] CSS Grid (not flex math)
[ ] Mobile collapses to single column

MOTION
[ ] Spring physics (no linear easing)
[ ] No bounce / elastic
[ ] Only transform/opacity animated
[ ] List reveals staggered
[ ] Reduced-motion respected
[ ] useEffect cleanup present

CONTENT
[ ] Realistic names (no John Doe)
[ ] Messy data (no 99.99%)
[ ] No "Acme" / "Nexus" / "SmartFlow"
[ ] No "Elevate / Seamless / Unleash" copy
[ ] No emojis (Phosphor / Radix only)
[ ] No broken Unsplash URLs

STATE
[ ] Loading skeletons (not spinners)
[ ] Empty states designed
[ ] Error states inline + actionable
[ ] Success feedback present

ARCHITECTURE
[ ] 'use client' only where needed
[ ] No state for hover position
[ ] No window.scroll listeners
[ ] Tailwind version syntax correct
[ ] Dependencies verified in package.json
```

If you can't tick every box, **don't say done.** Fix and re-check.
