# Frontend God Mode

A single Claude skill that turns Claude Code into a senior frontend designer + engineer. Consolidates UI/UX Pro Max, Framer Motion patterns, 21st.dev Magic, React Bits, Anthropic's frontend-design, Impeccable, and high-agency taste rules into one master skill.

**No more generic AI output.** No more Inter + purple gradients + 3-card feature rows.

---

## Quick start (TL;DR)

```bash
# Install (project-local)
npx skills add Shawnchee/frontend-god-mode

# Restart Claude Code, then in any frontend prompt — done.
```

That's it. Restart your editor, then describe what you want:

> "Build me a SaaS landing page for a B2B observability tool. Premium feel."

Need 21st.dev components too? See [21st.dev Magic Setup](#21stdev-magic-setup-optional) below — it's optional.

### If the skill doesn't auto-trigger

Skills auto-fire when Claude judges your prompt matches the skill description. Sometimes it doesn't fire (especially on terse prompts). When in doubt, **invoke it explicitly:**

```
/frontend-god-mode build me a landing page for [whatever]
```

Or in chat: "use the frontend-god-mode skill to build me a landing page..."

You'll know it fired when Claude opens with a one-line aesthetic statement (e.g., "Picking premium SaaS — Geist + Geist Mono, Slate neutrals, electric blue accent") before writing code, and when it audits the result against the pre-flight checklist.

---

## Prerequisites

- **Claude Code** — installed and signed in
- **Node 18+** — only needed when generated code imports npm packages (Framer Motion, shadcn, etc.)
- **(Optional) 21st.dev API key** — free, only needed if you want Claude to pull from 21st.dev's component library. Get it at https://21st.dev/magic/console

The skill itself is just markdown files. **No API keys, no installs, no background services required to use the skill on its own.** Keys and packages only matter when you opt in to specific integrations.

---

## What this fetches at runtime

**The skill: nothing.** It's ~70KB of plain markdown that Claude reads when you give it a frontend task. No HTTP calls, no telemetry.

**Libraries the skill writes code against (only fetch when YOU run them):**

| Integration         | API key?            | Cost  | Fetches when                         |
|---------------------|---------------------|-------|--------------------------------------|
| The skill itself    | No                  | Free  | Never — it's just markdown           |
| Framer Motion       | No                  | Free  | `npm install framer-motion`          |
| React Bits          | No                  | Free  | `npx shadcn add @react-bits/...`     |
| shadcn/ui           | No                  | Free  | `npx shadcn init`                    |
| **21st.dev Magic**  | **Yes (free tier)** | Free  | Claude calls the MCP server          |
| UI/UX Pro Max       | No                  | Free  | Optional secondary skill (skippable) |

---

## Install

### Using skills.sh (recommended)

Works with 45+ agents. One command.

```bash
# Project-local (current project only)
npx skills add Shawnchee/frontend-god-mode

# Global (all projects)
npx skills add Shawnchee/frontend-god-mode -g

# Specific agent
npx skills add Shawnchee/frontend-god-mode -a claude-code
npx skills add Shawnchee/frontend-god-mode -a cursor
npx skills add Shawnchee/frontend-god-mode -a windsurf

# CI-friendly (no prompts)
npx skills add Shawnchee/frontend-god-mode -g -a claude-code -y
```

### Manual

```bash
git clone https://github.com/Shawnchee/frontend-god-mode.git
```

Copy the skill folder for your agent:

| Agent              | Project                                | Global                       |
|--------------------|----------------------------------------|------------------------------|
| Claude Code        | `.claude/skills/`                      | `~/.claude/skills/`          |
| Cursor             | `.cursor/skills/`                      | `~/.cursor/skills/`          |
| Windsurf           | `.windsurf/skills/`                    | `~/.windsurf/skills/`        |
| Codex / OpenCode   | `.codex/skills/`                       | `~/.codex/skills/`           |
| Gemini CLI         | `.gemini/skills/`                      | `~/.gemini/skills/`          |
| Copilot            | `.github/copilot-instructions.md`      | —                            |
| Antigravity        | Project config directory               | —                            |

```bash
# Example: Claude Code, project-level
cp -r frontend-god-mode/frontend-god-mode .claude/skills/

# Example: Claude Code, global
cp -r frontend-god-mode/frontend-god-mode ~/.claude/skills/
```

Restart your editor after installing.

### One-line install script

```bash
curl -fsSL https://raw.githubusercontent.com/Shawnchee/frontend-god-mode/main/install.sh | bash
```

Installs globally for Claude Code. Restart after.

---

## Uninstall

```bash
npx skills remove frontend-god-mode
# or, manually:
rm -rf .claude/skills/frontend-god-mode
rm -rf ~/.claude/skills/frontend-god-mode
```

---

## Verify the install

After restarting your editor, prompt:

> "Build me a hero section for a B2B observability product"

The skill is firing if Claude opens with a one-line aesthetic statement (e.g., "Picking premium SaaS — Geist + Geist Mono, Slate neutrals, electric blue accent") before writing any code, AND audits the result against the pre-flight checklist at the end.

If it didn't fire automatically, prompt: `/frontend-god-mode build me a hero section…`

### Troubleshooting

| Symptom                                 | Fix                                                                 |
|-----------------------------------------|---------------------------------------------------------------------|
| Skill doesn't auto-trigger              | Prompt explicitly: `/frontend-god-mode <your task>` or "use the frontend-god-mode skill to..." |
| Skill files not found                   | `ls ~/.claude/skills/frontend-god-mode/SKILL.md` — confirm the path. Re-run install. |
| Listed but behavior not applied         | Fully restart Claude Code — close the terminal, don't just `/clear` or start a new chat. |
| Project-local install ignored           | Launch `claude` from the project root that contains `.claude/skills/`. |
| `/mcp` doesn't show `21st-dev-magic`    | Verify `.mcp.json` is at the project root, key is set, and you approved the security prompt on first launch. |

---

## 21st.dev Magic Setup (Optional)

21st.dev gives Claude access to 100+ production-ready components. The skill works fine without it — but if you want it, here's the setup.

### 1. Get a free API key

1. Go to https://21st.dev/magic/console
2. Sign in (Google/GitHub OAuth — free, takes 30 seconds)
3. Copy the API key from the dashboard

### 2. Add it as an MCP server

**Option 1 — Project-scoped (recommended)**

Create a `.mcp.json` at your project root:

```json
{
  "mcpServers": {
    "21st-dev-magic": {
      "command": "npx",
      "args": ["-y", "@21st-dev/magic@latest"],
      "env": {
        "API_KEY": "YOUR_KEY_HERE"
      }
    }
  }
}
```

Replace `YOUR_KEY_HERE` with your actual key. Then add `.mcp.json` to `.gitignore` so the key doesn't get committed:

```bash
echo ".mcp.json" >> .gitignore
```

If you want to commit the config without leaking the key, use an env var instead:

```json
"env": { "API_KEY": "${TWENTYFIRST_API_KEY}" }
```

Then `export TWENTYFIRST_API_KEY=...` before launching Claude Code.

**Option 2 — User-wide**

Edit `~/.claude.json` and add the same `21st-dev-magic` block under `mcpServers`. The MCP will be available in every project.

### 3. Restart Claude Code and approve

Close and reopen Claude Code in the project. The first time, it'll show a security prompt asking whether to enable the `21st-dev-magic` MCP server. Say yes.

Verify with `/mcp` — you should see `21st-dev-magic` listed as connected.

---

## Usage

The skill auto-triggers on any frontend / UI / design request. Just describe what you want:

- "Build me a SaaS landing page for a B2B observability tool"
- "Create a dashboard for analytics with a feature row"
- "Design a portfolio site for a typographer"
- "Add animations to this hero component"
- "Design a poster for a music festival in Mexico City, 1970s feel"

To run the install wizard for the underlying tools:

> /frontend-god-mode setup

---

## What the skill enforces

Every time you build, the skill:

1. **Picks an aesthetic direction** before coding (brutalist / editorial / luxury / playful / etc.)
2. **Loads only relevant references** for the task at hand
3. **Routes you to component libraries** when appropriate (21st.dev, React Bits, shadcn)
4. **Bans 24 AI tells** — Inter, purple gradients, John Doe, 3-card rows, h-screen, etc.
5. **Runs a pre-flight checklist** before reporting "done"

## The 5 hard rules

These override everything:

1. No Inter font.
2. No purple-to-blue gradient on white.
3. No `h-screen` on heroes (use `min-h-[100dvh]`).
4. No three equal cards in a row as features.
5. No generic data ("John Doe", "Acme", "$99.99").

---

## What's inside

```
frontend-god-mode/                       # repo root
├── frontend-god-mode/                   # the skill (this is what gets copied into .claude/skills/)
│   ├── SKILL.md                         # Main orchestrator (auto-loaded)
│   └── references/
│       ├── typography.md                # Approved fonts, banned defaults, free fallbacks
│       ├── color.md                     # OKLCH palettes, anti-purple rules, maximalist exception
│       ├── motion.md                    # Framer Motion + spring physics + perpetual motion
│       ├── layout.md                    # Asymmetric heroes, dashboard hardening, dvh
│       ├── components.md                # React Bits + 21st.dev + shadcn integration
│       ├── bento-engine.md              # Modern SaaS bento grid (marketing only)
│       ├── accessibility.md             # WCAG AA contrast, focus, keyboard, semantic HTML
│       ├── copy.md                      # Banned vocab, headline patterns, empty/error states
│       ├── anti-slop.md                 # 24 AI tells, pre-flight checklist
│       └── setup-walkthrough.md         # First-run install wizard
├── dist/
│   └── frontend-god-mode.skill          # Packaged installable (zip)
├── examples/
│   └── test-prompts.md                  # 5 test prompts with expected outputs
├── install.sh                           # One-line installer
└── README.md
```

---

## Test prompts

The skill is designed to pass these without generic output:

1. "Build a SaaS landing page"
2. "Create a dashboard for analytics"
3. "Make a portfolio site"
4. "Add animations to this component"
5. "Design a poster for a music festival"

See `examples/test-prompts.md` for a full A/B test plan (with vs without the skill).

---

## Stack credits

This skill consolidates and builds on:

- [UI/UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)
- [Framer Motion](https://www.framer.com/motion/)
- [21st.dev Magic](https://21st.dev/magic)
- [React Bits](https://reactbits.dev)
- [Anthropic frontend-design](https://github.com/anthropics/skills)
- [Impeccable](https://impeccable.style)
- [design-taste-frontend](https://github.com/leonxlnx/taste-skill)

## License

MIT.
