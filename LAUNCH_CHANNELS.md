# Launch Channel Content

> Copy-paste these on launch day. Each is tuned for its specific audience.

---

## Anthropic MCP Discord — #showcase or #mcp-servers

```
I built an MCP server that gives Claude Code persistent memory across sessions.

It captures decisions, preferences, and context during your session, stores them in local SQLite, and injects them back at the start of every future session. There's a quality gate (7 rules — dedup, sensitive data blocking, quality scoring) that keeps the memory database clean.

One command: npx @cortex.memory/cli init

Open source: https://github.com/ProductionLineHQ/cortex

Would appreciate feedback on the MCP tool design — I'm exposing 5 tools (get_context, save_memory, search, list_projects, get_status) and I'm not sure if that's the right surface area or if some should be collapsed.
```

---

## Twitter/X Thread (5 tweets)

**Tweet 1 (hook — 217 chars):**
```
Claude Code is the best AI coding tool I've used.

But every morning it forgets my entire project. Architecture, conventions, decisions from last week — gone.

I built a fix. Open source. One command install.
```

**Tweet 2 (install — 72 chars):**
```
npx @cortex.memory/cli init

That's it. Done.
```

**Tweet 3 (the moment — 276 chars):**
```
What happens after install:

You open Claude Code. Instead of "what are you working on?" it says:

"I see you're working on my-saas-app — Drizzle ORM, server components by default, investigating the WebSocket timeout issue. Where should we pick up?"

That's Cortex.
```

**Tweet 4 (trust — 223 chars):**
```
Everything stays on your machine.

Local SQLite. Localhost only. Zero telemetry. Quality gate blocks API keys and passwords from being stored.

Open source, MIT licensed. Read every line.

github.com/ProductionLineHQ/cortex
```

**Tweet 5 (CTA — 91 chars):**
```
Star if useful: github.com/ProductionLineHQ/cortex

Free for subscribers: theproductionline.ai
```

---

## LinkedIn Post

```
Every engineering team using Claude Code is losing 15-30 minutes per developer per day re-establishing context.

Claude Code starts every session from zero. No memory of yesterday's architecture decisions. No awareness of coding conventions. No knowledge of the open threads from last week.

For a team of 10 engineers, that is 2.5 to 5 hours of lost productivity every single day — not from bad tooling, but from the AI forgetting what it already learned.

I built Cortex to fix this. It is an open-source MCP server that gives Claude Code persistent memory. Decisions, context, preferences — captured automatically during sessions and injected back into every future session.

The key insight: a quality gate with 7 validation rules prevents the memory database from filling with noise. Without it, you get a notes file. With it, you get a reliable knowledge base that makes AI compound over time instead of resetting every morning.

Local-first (SQLite on your machine), open source (MIT), one command install.

For engineering leaders evaluating AI developer tools: this is the missing layer between "AI coding assistant" and "AI team member that learns."

Product page: https://www.theproductionline.ai/tools/cortex
GitHub: https://github.com/ProductionLineHQ/cortex

Subscribe to The Production Line newsletter for free access and weekly AI intelligence for enterprise teams.
```
