# Setup Walkthrough

Run this when the user asks to "set up" their environment, says "/website-builder-setup", or you detect a fresh project with no design dependencies. Walk them through ONE step at a time. Be encouraging. Assume zero coding experience.

If any step fails, **don't stop**. Acknowledge it, give them the manual command, and keep moving.

---

## Step 0 — Check Prerequisites

Tell the user:

> Before we start, let me check what you have installed.

Run silently:
```bash
node --version 2>&1 && npm --version 2>&1
```

- **If Node is installed** → "You're good. Node and npm are ready. Let's go."
- **If Node is missing** → tell them:

> You need Node.js first. Go to **https://nodejs.org** and grab the LTS version. Install it, restart your terminal, then come back and we'll continue. Takes 2 minutes.

Stop here if Node is missing.

---

## Step 1 of 4 — UI/UX Pro Max (optional augmentation)

Tell them:

> **Step 1 of 4: UI/UX Pro Max** (optional)
>
> If you want extra design vocabulary on top of frontend-god-mode, UI/UX Pro Max is a Claude skill that adds 50+ styles, 161 palettes, 57 font pairings. **It's optional** — frontend-god-mode already covers the essentials. But if you want it, install via:
>
> ```bash
> npx skills add @nextlevelbuilder/ui-ux-pro-max-skill
> ```
>
> If that command doesn't work in your environment, skip this step. The base frontend-god-mode skill works on its own.

This step is **optional**. Don't block on failure. Move to Step 2 immediately whether they install or skip.

---

## Step 2 of 4 — Framer Motion

Tell them:

> **Step 2 of 4: Framer Motion**
>
> This is what teaches me how to animate things — smooth page transitions, hover effects, scroll-triggered reveals. The stuff that makes a $500 site look like a $10,000 site.
>
> Installing now...

Run:
```bash
npm install framer-motion 2>&1
```

- **On success** → "Done. Your sites will move now."
- **On failure** → "Couldn't install it here — that's usually because we're not in a project folder yet. When you start a project, I'll add it then. Moving on."

---

## Step 3 of 4 — React Bits

Tell them:

> **Step 3 of 4: React Bits**
>
> This is a library of 110+ animated components — text effects, animated backgrounds, hover interactions. We pull these in via shadcn when we need them, so no upfront install. I'll just call them like:
>
> ```bash
> npx shadcn@latest add @react-bits/BlurText-TS-TW
> ```
>
> when we're building. Nothing for you to do here. Continuing.

(Just confirm understanding, no install.)

---

## Step 4 of 4 — 21st.dev Magic

Tell them:

> **Step 4 of 4: 21st.dev Magic**
>
> This connects me to a library of 100+ production-ready React components — buttons, navbars, hero sections. I pull from these when we need a "looks designed" building block fast.
>
> This one needs a free API key. Here's how:
>
> 1. Go to **https://21st.dev/magic/console**
> 2. Sign up or log in (it's free)
> 3. Copy your API key
> 4. Paste it here when ready.

**WAIT for the user to provide the key.** Don't proceed without it.

When they paste the key, **first ask them where they want it scoped:**

> Do you want this scoped to just this project, or available everywhere?
>
> **a. Project-only (recommended for testing)** — writes a `.mcp.json` at the current project root. Adds it to `.gitignore` so the key never gets committed.
>
> **b. User-wide (everywhere)** — writes to `~/.claude.json`. Available in every project Claude Code opens.

If they pick **a (project-only):**

1. Detect project root: nearest ancestor directory with `package.json`, `.git`, or fall back to current working directory.
2. Write `.mcp.json` at the root (create if missing, merge if exists):
   ```json
   {
     "mcpServers": {
       "21st-dev-magic": {
         "command": "npx",
         "args": ["-y", "@21st-dev/magic@latest"],
         "env": { "API_KEY": "THEIR_KEY_HERE" }
       }
     }
   }
   ```
3. Append `.mcp.json` to `.gitignore` if not already present (create `.gitignore` if missing).

If they pick **b (user-wide):**

1. Read `~/.claude.json`.
2. Find or create the `mcpServers` object.
3. Add the same `21st-dev-magic` entry above.
4. Save the file.

Then tell them:

> 21st.dev is wired up. You'll need to **restart Claude Code** for it to load — close and reopen your terminal after we finish. The first launch will show a security prompt asking to approve the MCP — say yes.

---

## Step 5 — Done

Tell them:

> **You're all set.** Here's what you just installed:
>
> - **UI/UX Pro Max** — 50+ styles, 161 palettes, 57 font pairings
> - **Framer Motion** — production-grade animations
> - **React Bits** — 110+ animated components, ready via shadcn
> - **21st.dev Magic** — 100+ production components via MCP
>
> Plus, this skill itself (frontend-god-mode) gives me the taste rules to use them well — typography, color, layout, motion, anti-slop guards.
>
> **To build your first site, just describe what you want:**
>
> - What does your business / product do?
> - Who's the audience?
> - What vibe? (luxury / brutalist / playful / minimal / editorial / retro-futuristic / etc.)
>
> Try something like:
>
> > "Build me a landing page for a small-batch coffee roaster targeting at-home espresso enthusiasts. Editorial vibe, warm tones, lots of whitespace, subtle scroll animations."
>
> **Restart Claude Code first** so 21st.dev loads. Then let's build something that doesn't look AI-generated.

---

## Walkthrough Rules

- **One step at a time.** Never dump all 4 steps in one message.
- **Encouraging tone.** Casual, friendly, no jargon.
- **Don't stop on failure.** Acknowledge, give manual command, keep moving.
- **Wait for the API key** at Step 4 — don't fabricate one or skip.
- **Confirm understanding** at React Bits step before continuing.
- **End with a concrete prompt suggestion** so they know what to ask next.
