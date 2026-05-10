# Contributing to frontend-god-mode

Thanks for wanting to make this better. The skill is a curated set of opinions — every contribution should sharpen those opinions, not soften them.

## What this skill is

A markdown-only Claude Code skill. No build step, no runtime, no dependencies. The whole project is `frontend-god-mode/SKILL.md` + `frontend-god-mode/references/*.md`. If you can write a clear opinion in markdown, you can contribute.

## Local setup

```bash
git clone https://github.com/Shawnchee/frontend-god-mode.git
cd frontend-god-mode
```

That's the whole setup. There's nothing to install.

To test your changes locally:

```bash
# Install your local copy into Claude Code (project-local)
cd /path/to/some/test/project
mkdir -p .claude/skills/frontend-god-mode
cp -r ~/path/to/cloned/frontend-god-mode/frontend-god-mode/* .claude/skills/frontend-god-mode/
# Restart Claude Code, then prompt against your changes
```

## What we accept

**Strong yes:**
- New aesthetic profiles in `references/` (e.g., a deeper brutalist guide, a print/poster reference, a mobile-first reference)
- New rows in the anti-slop catalog — but only with a *concrete reason* the pattern is bad and a *specific replacement*
- More font pairings in `typography.md` with named contexts (don't just add fonts; show when to use them)
- Real Framer Motion / GSAP / Three.js patterns we don't yet cover, with full code examples
- Bug fixes for contradictions between references (we've already had one between `bento-engine.md` and `layout.md` — find more)
- Free-font fallback updates as the type ecosystem changes

**Strong no:**
- "It depends" guidance. The skill is intentionally prescriptive. If you find yourself writing "use X or Y depending on context," pick one.
- Adding generic options (e.g., "Inter is fine if used carefully" — no, Inter stays banned)
- Rephrasing existing rules to be softer
- Accessibility shortcuts. The a11y checklist only grows; it doesn't shrink.
- Brand-specific hacks (e.g., "for shadcn projects, do X differently"). Keep the skill framework-agnostic where possible.

## Style guide

The skill's voice is direct and concrete. Match it.

- **Imperative mood.** "Use Geist." Not "You might want to consider Geist."
- **No filler.** Banned: "leverage," "elevate," "seamless," "unleash," "next-gen," "in the realm of."
- **Concrete examples.** Show real OKLCH values, real spring physics numbers, real Tailwind classes — not "appropriate spacing."
- **One opinion per rule.** If a rule has three escape hatches, it's not a rule.
- **No emojis** in the skill content. Phosphor / Radix icons only.

## Testing your change

Skill changes don't have unit tests, but they DO have a real test:

1. Pick a target prompt (e.g., "build a dashboard for analytics")
2. Run it through Claude Code with the OLD skill — save the output
3. Apply your change, install the skill again, run the SAME prompt — save the output
4. Diff the outputs. Your change should produce a *materially better* result, or it shouldn't ship.

For larger changes, also do an internal "dry-run audit" — open a Claude session, paste the entire SKILL.md + your changed reference, and ask Claude to walk through 3 representative prompts. This catches contradictions and ambiguity fast.

## PR checklist

Before opening a PR, confirm:

- [ ] Your change adds a *prescriptive opinion*, not a hedge
- [ ] Any new rule has a real failure mode it's preventing
- [ ] Voice matches the existing references (direct, imperative, no filler)
- [ ] You've tested with at least one real prompt and seen the difference
- [ ] If you added a banned pattern, you also added the approved replacement
- [ ] If you added a reference file, you wired it into `SKILL.md`'s routing table
- [ ] No accidental sycophancy: "great question," "absolutely," etc.

## Commit format

Imperative subject, ≤72 chars. Concise body explaining the *why* — what failure mode this prevents, what was contradictory before, what was missing.

```
Add italic-serif eyebrow pattern to typography.md

The editorial luxury aesthetic kept producing centered all-caps
eyebrows that read as boring SaaS marketing. Italic serif eyebrows
above sans-serif H2s are a stronger editorial signal — added to
the OpenType section with a working code example.
```

End the commit body with the Co-Authored-By line if you got help from an AI:

```
Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
```

## How to propose a new reference file

Open an issue first. Title: "New reference: <topic>". Describe:
- What aesthetic / use case it covers
- What's currently missing (be specific — point to a Claude output that failed)
- An outline of sections you'd include

We'll discuss scope before you write it. New references are a real expansion of the skill's surface area.

## Reporting bugs

A "bug" in this skill is one of:
- A contradiction between two references
- A rule the skill mandates that produces visibly worse output than ignoring it
- A trigger keyword in `SKILL.md`'s description that's missing (the skill doesn't auto-fire on a prompt it should)
- A factual error (wrong Tailwind syntax, broken Framer Motion API, paid font listed as free)

Open an issue with the prompt that exposed it, the actual output, and the expected output.

## License

By contributing, you agree your contributions are licensed under MIT (same as the project).
