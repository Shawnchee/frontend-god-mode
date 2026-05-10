# Typography Reference

Typography is the single highest-leverage design choice. Get it right and everything else looks expensive. Get it wrong and the whole thing looks like a default ChatGPT artifact.

## The Banned List

Never use these unless the user explicitly demands them:

- **Inter** — the AI tell. Banned for "premium" and "creative" projects.
- **Roboto, Arial, Helvetica, system-ui** — generic, lifeless.
- **Times New Roman, Georgia** as body — dated.
- **Comic Sans, Papyrus, Lobster** — unless explicitly requested for ironic/playful contexts.

## The Approved Stack — Pick One Pairing Per Project

Match the pairing to the aesthetic direction. **Do not cross pairings.** Do not always pick Space Grotesk.

### For premium SaaS / dashboards / software UIs
- **Display + body:** Geist + Geist Mono
- **Display + body:** Satoshi + JetBrains Mono
- **Display + body:** Cabinet Grotesk + Inter Tight (only Tight, never plain Inter)
- Mono numbers are mandatory for tabular data (`font-mono` on metrics).

### For creative / editorial / agency
- **Display:** PP Editorial New (italic), Reckless, Tiempos Headline, Söhne Breit
- **Body:** Söhne, Söhne Buch, Inter Display (the display cut, NOT regular Inter)
- **Accent:** Italic serif eyebrow + sans body for editorial pop

### For brutalist / industrial
- **Display:** Neue Haas Grotesk, Akkurat Mono, IBM Plex Mono
- **Body:** Inter Tight, Söhne Mono
- **All-caps with tight tracking** for headers

### For luxury / refined
- **Display:** GT Sectra, Canela, PP Editorial New
- **Body:** Söhne, Inter Display, Cormorant Garamond (body italic)

### For playful / toy
- **Display:** Cooper BT, Bagel Fat One, Outfit at heavy weights
- **Body:** Outfit, Plus Jakarta Sans

### For retro-futuristic / tech
- **Display:** Space Grotesk (use sparingly — overused), Departure Mono, JetBrains Mono
- **Body:** Inter Tight, Söhne Mono

## Hierarchy Rules

- **Display H1:** `text-4xl md:text-6xl lg:text-7xl tracking-tighter leading-[0.95]`
- **H2:** `text-2xl md:text-4xl tracking-tight leading-tight`
- **H3:** `text-xl md:text-2xl tracking-tight`
- **Body:** `text-base leading-relaxed max-w-[65ch]` — never wider than 65 characters
- **Small / caption:** `text-sm text-zinc-500 tracking-wide uppercase` (uppercase only for labels under 4 words)

## Anti-Patterns

- **Oversized H1 that screams.** Control hierarchy with weight + color, not just scale.
- **Serif on a dashboard.** Banned. Dashboards = clean sans-serif only.
- **Gradient text fill on large headers.** Cliché. Use solid color with tight tracking instead.
- **All-caps body copy.** Never. All-caps is for labels < 4 words.
- **`text-center` on long paragraphs.** Left-aligned is more readable. Center only short hero copy or eyebrows.
- **Ignoring optical kerning.** Display headers need `tracking-tighter` or `tracking-tight`.

## Loading Fonts (Next.js)

```ts
// app/layout.tsx
import { Geist, Geist_Mono } from 'next/font/google';
// or for non-Google fonts, use a self-hosted local font
import localFont from 'next/font/local';

const geist = Geist({ subsets: ['latin'], variable: '--font-sans' });
const geistMono = Geist_Mono({ subsets: ['latin'], variable: '--font-mono' });
```

## Font Licensing & Free Fallbacks

Some recommended fonts are paid/licensed. Use these free fallbacks if the user can't or won't license:

| Paid font            | Free fallback                                           |
|----------------------|---------------------------------------------------------|
| PP Editorial New     | Instrument Serif (Google Fonts)                         |
| Söhne                | Inter Tight (Google) — only the Tight cut, never plain  |
| GT Sectra            | Fraunces (Google), or Cormorant Garamond                |
| Cabinet Grotesk      | Inter Tight, or Outfit                                  |
| Reckless             | Newsreader (Google)                                     |
| Tiempos Headline     | Source Serif Pro (Google)                               |
| Neue Haas Grotesk    | Inter Tight (only Tight)                                |
| Akkurat Mono         | JetBrains Mono (Google)                                 |
| Cooper BT            | Bagel Fat One (Google)                                  |
| Söhne Mono           | JetBrains Mono                                          |

**Free fonts that always work** (Google Fonts):
- Geist + Geist Mono — premium SaaS default
- JetBrains Mono — mono UI/data
- Outfit — playful, modern
- Plus Jakarta Sans — clean body
- Instrument Serif — editorial display
- Fraunces — luxury/editorial display
- Newsreader — editorial body
- Departure Mono — retro tech

If serving a paid font, always use `next/font/local` (not `next/font/google`) and host the .woff2 yourself.

## Font Pairing Examples That Always Work

| Aesthetic        | Display          | Body             | Mono           |
|------------------|------------------|------------------|----------------|
| Premium SaaS     | Geist            | Geist            | Geist Mono     |
| Editorial agency | PP Editorial New | Söhne            | —              |
| Brutalist        | Neue Haas Grotesk| Inter Tight      | IBM Plex Mono  |
| Luxury           | GT Sectra        | Söhne            | —              |
| Playful          | Outfit (Heavy)   | Plus Jakarta Sans| —              |
| Retro tech       | Departure Mono   | Inter Tight      | JetBrains Mono |

## OpenType Tips

- Enable tabular numbers for data: `font-feature-settings: 'tnum'`
- Enable contextual alternates for display: `font-feature-settings: 'ss01', 'cv01'`
- For italic serif eyebrows above headers: works wonders on editorial layouts

## Mandatory Final Check

Before shipping:
- [ ] Body line-height is at least 1.5
- [ ] Body width is capped at `max-w-[65ch]`
- [ ] Display tracking is tightened (`tracking-tight` minimum)
- [ ] No Inter (regular cut) anywhere in the project
- [ ] Hierarchy reads in three glances: title, subtitle, body
- [ ] At most TWO type families per project (display + body, plus optional mono)
