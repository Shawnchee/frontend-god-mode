# Copy & Microcopy Reference

Bad copy gives away AI output as fast as Inter does. "Elevate your seamless next-gen experience" is the textual equivalent of a purple gradient. This reference fixes that.

## The Banned Vocabulary

These words signal AI output. Replace every instance:

| Banned word        | Why it sucks                          | Use instead                                |
|--------------------|---------------------------------------|--------------------------------------------|
| Elevate            | Empty buzzword                        | Concrete verb (improve, refine, ship)      |
| Seamless           | Means nothing, used everywhere        | Cut, or describe what's actually smooth    |
| Unleash            | Sales-speak                           | Cut, or use a verb tied to user benefit    |
| Next-gen           | Generic                               | Be specific about what makes it new        |
| Game-changing      | Cliché                                | State the actual change                    |
| Revolutionary      | Almost never true                     | Cut, describe the difference               |
| Cutting-edge       | Self-congratulatory                   | Show, don't tell                           |
| Robust             | Vague                                 | Specific quality (handles 1M req/s, etc.)  |
| Powerful           | Says nothing                          | Specific capability                        |
| Innovative         | Self-applied is suspicious            | Concrete novel behavior                    |
| Streamline         | Corporate-speak                       | Specific shortcut/improvement              |
| Empower            | HR-speak                              | Concrete verb                              |
| Best-in-class      | Marketing slop                        | Cite actual benchmark or cut               |
| World-class        | Same                                  | Same                                       |
| Solution           | Generic                               | Name the specific tool/feature             |
| Holistic           | Hollow                                | Describe what's covered                    |
| Synergy            | 2002 corporate                        | Cut entirely                               |
| Leverage (verb)    | Consultant-speak                      | "Use" — works fine                         |
| In the realm of... | AI tone                               | State the topic directly                   |
| Whether you're...  | Listicle opener                       | State who it's for plainly                 |
| From X to Y        | Lazy spectrum                         | Specific examples                          |

## Hero Headline Patterns

### What works
- **Specific outcome:** "Catch p99 spikes before PagerDuty does."
- **Anti-cliché twist:** "We don't make the dashboard prettier. We make it stop lying."
- **Plainspoken benefit:** "Receipts. In your inbox. Within 90 seconds."
- **Confident understatement:** "Logs that don't ruin your weekend."
- **Direct address:** "You ship faster with fewer bugs."

### What doesn't
- ❌ "Elevate your business with our seamless solution"
- ❌ "Unleash the power of next-gen analytics"
- ❌ "Revolutionary platform for modern teams"
- ❌ "From idea to launch — we've got you covered"

## Subhead Patterns

Always concrete. Often specific numbers or named technologies.

✅ "Drop-in replacement for Datadog logs. 1/4 the price."
✅ "TypeScript SDK, REST API, and a CLI. No SDK lock-in."
✅ "Tested at 50M events/day. Production since 2024."

❌ "A comprehensive solution for all your observability needs"
❌ "Built for the modern enterprise"
❌ "Powering teams worldwide"

## Button Labels

### Always (good defaults)
- "Get started" — for free signups
- "Start free trial" — when there IS a trial
- "See pricing" — for SaaS that won't show pricing inline
- "Talk to sales" — only if you're enterprise-only
- "Read the docs" — for dev-tooling
- "Watch demo (90s)" — include the duration

### Specific over generic
- ✅ "Send invoice" → not "Submit"
- ✅ "Save draft" → not "Save"
- ✅ "Cancel reservation" → not "Cancel"
- ✅ "Delete project" → not "Delete"

### Banned
- ❌ "Click here"
- ❌ "Submit" (always more specific)
- ❌ "Learn more" (use "See how it works" or specific)
- ❌ "Sign up now" (the "now" is filler)
- ❌ ALL CAPS (unless brand intentional)

## Empty States

The default AI empty state is "No results found." Don't.

### Pattern
```
[Title] - what's missing, in plain language
[Body] - one short line explaining how to populate it
[Action button] - the verb to fix it
```

### Examples

✅ **Good:**
> **No invoices yet.**
> Once you create your first invoice, it'll show up here.
> [Create invoice]

✅ **Good:**
> **You're all caught up.**
> No new mentions. We'll notify you when something needs your attention.

❌ **Bad:**
> No items found
> Try adjusting your filters
> [Clear filters]

## Error Messages

Errors should be honest, specific, and actionable.

### Pattern
```
[What broke, plainly]. [How to fix it, if known].
```

### Examples

✅ **Good:**
> "We couldn't reach the payment processor. Check your connection and try again — we didn't charge you."

✅ **Good:**
> "Email format looks off. Should be like name@example.com."

✅ **Good:**
> "Project deleted. Undo within 30 seconds."

❌ **Bad:**
> "Something went wrong. Please try again."
> "Error: 500 Internal Server Error"
> "Invalid input"

## Loading States

Don't say "Loading..." Show what's happening.

✅ "Fetching the last 30 days..."
✅ "Compiling your TypeScript (47 files)..."
✅ "Sending invoice to mira@lattice.co..."

❌ "Loading..."
❌ "Please wait..."

## Microcopy in Forms

### Field labels
- Concrete: "Email" not "Email address"
- Imperative: "Project name" not "Name your project"

### Placeholders (NOT labels — use real labels)
- Show format: `name@company.com`, not `Enter email`
- Show example: `Q3 launch plan`, not `Enter project name`

### Helper text (under field, before user types)
- One short line max
- Anticipates the question they'd ask

✅ "We'll only use this to send the receipt."
✅ "8+ characters, including a number."

### Validation errors (under field, after submit)
- Lead with what's wrong
- Then how to fix

✅ "Password too short. Add 4 more characters."
✅ "That email's already in use. Sign in instead?"

## Brand / Product Names (When Inventing Placeholders)

The skill bans "Acme", "Nexus", "SmartFlow." Use these patterns instead:

### Premium SaaS
- Lattice & Co.
- Provenance Studio
- Tessellate Labs
- Rivulet
- Fathom
- Cinder & Spar
- Threadwell
- Northstar Compute

### Editorial / agency
- Polaris Atelier
- Margin Press
- The Saturn Office
- Foundry & Foil
- Halftone Magazine

### Industrial / dev
- Westmark Tools
- Sparkplug Systems
- Apsis Dev
- Beacon Logs
- Raven CI

### People names (avoid John Doe / Sarah Chen)

✅ Mira Okonkwo, Theo Vasquez, Lin Park-Aboagye, Kavi Subramanian, Aitana Reyes, Bram Holst, Yuna Ozaki, Imani Bright, Casper Holm, Noor Kazemi

❌ John Doe, Jane Smith, Sarah Chen, Mike Wilson, Jack Su

## Final Copy Audit

- [ ] No banned words (Elevate, Seamless, Unleash, Next-Gen, etc.)
- [ ] Hero headline is specific and concrete (not generic benefit)
- [ ] Button labels use specific verbs (not "Submit" / "Click here")
- [ ] Empty states designed (not "No results found")
- [ ] Error messages explain what broke and how to fix
- [ ] Loading states show progress detail
- [ ] Form placeholders show format, not duplicate labels
- [ ] Sample data uses realistic, varied names (no John Doe)
- [ ] Brand placeholders aren't Acme / Nexus
- [ ] No emojis as decoration in copy (use Phosphor / Radix icons)
