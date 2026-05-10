# Frontend God Mode

A single Claude skill that turns Claude Code into a senior frontend designer + engineer. Consolidates UI/UX Pro Max, Framer Motion patterns, 21st.dev Magic, React Bits, Anthropic's frontend-design, Impeccable, and high-agency taste rules into one master skill.

**No more generic AI output.** No more Inter + purple gradients + 3-card feature rows.

---

## Quick start (TL;DR)

```bash
# 1. Get the skill (use git clone once published; for now: clone or copy locally)
git clone https://github.com/shawnchee/frontend-god-mode.git

# 2. Install user-wide so it loads in every project
mkdir -p ~/.claude/skills/frontend-god-mode
cp -r frontend-god-mode/skill/* ~/.claude/skills/frontend-god-mode/

# 3. Restart Claude Code (close + reopen the terminal)

# 4. Verify — in any Claude Code session, type:
#    /skills
#    You should see "frontend-god-mode" listed.
```

That's it. The skill auto-triggers on any frontend / UI prompt. Just describe what you want:

> "Build me a SaaS landing page for a B2B observability tool. Premium feel."

Need 21st.dev components too? See [21st.dev Magic Setup](#21stdev-magic-setup-optional) below — it's optional.

**If `/skills` doesn't show it:**
- Confirm the files exist: `ls ~/.claude/skills/frontend-god-mode/SKILL.md`
- Make sure you fully restarted Claude Code (not just a new chat — fully reopen the terminal)

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

### Option A — Project-local (recommended for testing)

The skill only loads when Claude Code is launched from this project. Nothing touches your home directory.

```bash
# 1. Clone this repo somewhere
git clone https://github.com/shawnchee/frontend-god-mode.git ~/frontend-god-mode

# 2. Inside YOUR project, copy the skill into .claude/skills/
cd /path/to/your-project
mkdir -p .claude/skills/frontend-god-mode
cp -r ~/frontend-god-mode/skill/* .claude/skills/frontend-god-mode/

# 3. Restart Claude Code (close + reopen) and launch it from your project root
claude
```

### Option B — User-wide (all projects)

The skill is auto-available in any project Claude Code opens.

```bash
git clone https://github.com/shawnchee/frontend-god-mode.git ~/frontend-god-mode
mkdir -p ~/.claude/skills/frontend-god-mode
cp -r ~/frontend-god-mode/skill/* ~/.claude/skills/frontend-god-mode/
```

Restart Claude Code.

### Option C — From the .skill bundle

If you only have the zipped bundle:

```bash
# Project-local
unzip frontend-god-mode.skill -d /path/to/your-project/.claude/skills/frontend-god-mode/

# Or user-wide
unzip frontend-god-mode.skill -d ~/.claude/skills/frontend-god-mode/
```

### Option D — One-line install (after the repo is published to GitHub)

> **Note:** This option only works once `shawnchee/frontend-god-mode` is published. Until then, use Option A or B.

```bash
curl -fsSL https://raw.githubusercontent.com/shawnchee/frontend-god-mode/main/install.sh | bash
```

This installs user-wide (Option B).

---

## Verify the install

After restarting Claude Code, run this in any session:

```
/skills
```

You should see `frontend-god-mode` listed as available. Then try:

> "Build me a hero section for a B2B observability product"

Claude should open with a one-line aesthetic statement (e.g., "Picking premium SaaS — Geist + Geist Mono, Slate neutrals, electric blue accent") before writing any code. If it does, the skill is working.

### Troubleshooting

| Symptom                                 | Fix                                                                 |
|-----------------------------------------|---------------------------------------------------------------------|
| `/skills` doesn't list `frontend-god-mode` | Verify files: `ls ~/.claude/skills/frontend-god-mode/SKILL.md`. Confirm the path exists. |
| Listed but skill behavior isn't applied | Fully restart Claude Code — close the terminal, don't just /clear or start a new chat. |
| Project-local install (Option A) ignored | Make sure you launch `claude` from the project root that contains `.claude/skills/`. |
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
frontend-god-mode/
├── skill/
│   ├── SKILL.md                    # Main orchestrator (auto-loaded)
│   └── references/
│       ├── typography.md           # Approved fonts, banned defaults, free fallbacks
│       ├── color.md                # OKLCH palettes, anti-purple rules, maximalist exception
│       ├── motion.md               # Framer Motion + spring physics + perpetual motion
│       ├── layout.md               # Asymmetric heroes, dashboard hardening, dvh
│       ├── components.md           # React Bits + 21st.dev + shadcn integration
│       ├── bento-engine.md         # Modern SaaS bento grid (marketing only)
│       ├── accessibility.md        # WCAG AA contrast, focus, keyboard, semantic HTML
│       ├── copy.md                 # Banned vocab, headline patterns, empty/error states
│       ├── anti-slop.md            # 24 AI tells, pre-flight checklist
│       └── setup-walkthrough.md    # First-run install wizard
├── dist/
│   └── frontend-god-mode.skill     # Packaged installable (zip)
├── examples/
│   └── test-prompts.md             # 5 test prompts with expected outputs
├── install.sh                      # One-line installer
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
