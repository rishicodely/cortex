# Launch Playbook — Cortex v1.0.0

> Internal document. Not committed to repo. Use these posts on launch day.

---

## 1. Show HN (Hacker News)

**Title:**
```
Show HN: Cortex – Persistent memory for Claude Code (open source)
```

**Post body:**
```
Hey HN,

I built Cortex because I got tired of re-explaining my architecture to Claude Code every morning.

Claude Code is incredible at coding, but every session starts from zero. No memory of yesterday's decisions. No awareness of your preferences. No knowledge of the open threads from last week. You re-explain everything, every time.

Cortex fixes this. It's a local daemon that runs alongside Claude Code, captures decisions/preferences/context as structured memories, and silently injects them into every new session via MCP. Your AI starts every conversation fully informed.

Key design decisions:

- Local-first: SQLite on your machine. Nothing leaves unless you enable sync.
- Quality gate: 6-rule engine prevents garbage memories (length, duplicates, sensitive data, quality score).
- Multi-machine sync: Optional Turso-powered sync. You own the database — we never see your data.
- One command install: `npx @cortex-memory/cli init`

Tech stack: TypeScript monorepo (9 packages), SQLite via better-sqlite3, Fastify REST API, MCP protocol, Next.js dashboard, SwiftUI Mac app, VS Code extension.

Open source, MIT licensed.

Repo: https://github.com/ProductionLineHQ/cortex
```

---

## 2. Reddit Posts

### r/ClaudeAI

**Title:**
```
I built an open-source persistent memory layer for Claude Code — it remembers your decisions, preferences, and context across every session
```

**Body:**
```
Claude Code is amazing but stateless. Every session = blank slate. I built Cortex to fix that.

What it does:
- Runs as a local MCP server alongside Claude Code
- Captures decisions, preferences, open threads as structured memories
- Injects relevant context at the start of every session
- Quality gate ensures only useful memories are saved (blocks duplicates, sensitive data, low-quality content)
- Optional multi-machine sync via Turso (you own the DB)

One command install:
npx @cortex-memory/cli init

Open source (MIT): https://github.com/ProductionLineHQ/cortex

Built with TypeScript, SQLite, Fastify, MCP protocol. Also includes a Next.js dashboard, VS Code extension, and native SwiftUI Mac app.

Would love feedback from other Claude Code users. What context do you find yourself re-explaining the most?
```

### r/programming

**Title:**
```
Cortex: Open-source persistent memory for Claude Code — local-first SQLite, MCP protocol, quality-gated memories
```

### r/opensource

**Title:**
```
Just open-sourced Cortex — a persistent memory layer for Claude Code (TypeScript, SQLite, MCP, MIT license)
```

---

## 3. X/Twitter Thread

```
Thread: 🧵

1/ I just open-sourced Cortex — persistent memory for Claude Code.

Every Claude Code session starts from zero. No memory of yesterday. Cortex fixes that.

One command: npx @cortex-memory/cli init

github.com/ProductionLineHQ/cortex

2/ The problem:

Claude Code is brilliant at coding. But it has amnesia.

Every morning you re-explain your architecture, your preferences, your conventions. It's like hiring a genius contractor who forgets everything overnight.

3/ How Cortex works:

- Runs as a local daemon (localhost:7434)
- Provides MCP tools to Claude Code
- Captures decisions, preferences, context as structured memories
- Injects relevant memories at session start

Your AI starts every conversation fully informed.

4/ The quality gate is what makes it work:

6 rules. Every memory must pass:
✓ Length (50-2000 chars)
✓ No banned phrases ("I will now...")
✓ No sensitive data (API keys, passwords)
✓ Quality score (specificity, technical terms)
✓ No duplicates (TF-IDF similarity check)
✓ Rate limit (50/session, 200/day)

5/ Local-first architecture:

- SQLite on your machine
- Nothing leaves unless YOU enable sync
- Turso sync = your database, your account
- We never see your memories
- AES-256-GCM encrypted credentials
- Zero telemetry by default

6/ What's included (it's a full platform):

- CLI with 30+ commands
- Next.js dashboard
- VS Code extension
- Native SwiftUI Mac app
- Electron desktop app
- Session summarizer (AI reviews what you missed)
- Multi-machine Turso sync

7/ Tech stack for the curious:

- TypeScript monorepo (9 packages)
- SQLite via better-sqlite3
- Fastify REST API + SSE
- MCP protocol (Model Context Protocol)
- Next.js 14 dashboard
- SwiftUI (macOS 13+)
- Electron + electron-builder
- Zod validation on every endpoint

8/ It's MIT licensed and fully open source.

If you use Claude Code, give it a try:

npx @cortex-memory/cli init

Star if useful: github.com/ProductionLineHQ/cortex

Built by @[your_handle] at K2N2 Studio.
```

---

## 4. LinkedIn Post

```
I just open-sourced Cortex — a persistent memory layer for Claude Code.

The problem: Claude Code starts every session from zero. No memory of previous conversations, no awareness of past decisions, no knowledge of your preferences.

For engineering teams, this means 15-30 minutes per developer per day re-establishing context. For a team of 10, that's 2.5-5 hours of lost productivity every single day.

Cortex fixes this by running a local daemon that captures decisions, preferences, and context as structured memories — then silently injects them into every new session.

Key principles:
→ Local-first: SQLite on your machine, nothing leaves unless you enable sync
→ Quality-gated: 6-rule engine prevents low-quality or duplicate memories
→ Privacy-respecting: zero telemetry, you own your data, clean uninstall
→ One command install: npx @cortex-memory/cli init

For CTOs and engineering leaders: this is the tool that makes your team's AI investment compound over time instead of resetting every morning.

Open source (MIT): https://github.com/ProductionLineHQ/cortex

#AI #DeveloperTools #ClaudeCode #OpenSource #Engineering
```

---

## 5. Dev.to / Hashnode Article

**Title:**
```
I Built Persistent Memory for Claude Code — Here's the Architecture
```

**Outline:**
1. The problem (2 paragraphs — relatable pain)
2. The solution (what Cortex does)
3. Architecture deep dive (ASCII diagram, data flow)
4. Quality gate design (6 rules, why each matters)
5. Sync architecture (Turso, conflict resolution)
6. Security model (local-first, encrypted credentials)
7. What's next (roadmap)
8. Try it: `npx @cortex-memory/cli init`

---

## 6. Launch Day Checklist

### Pre-launch (day before):
- [ ] Verify repo looks good on GitHub (README renders, badges work)
- [ ] Star your own repo (yes, seriously — first star matters)
- [ ] Enable GitHub Discussions
- [ ] Create 3-5 "good first issue" labels
- [ ] Tweet a teaser: "Shipping something tomorrow for Claude Code users..."

### Launch day (morning):
- [ ] Submit to Hacker News (Show HN) — aim for 8-9am ET
- [ ] Post to r/ClaudeAI
- [ ] Post to r/programming
- [ ] Post to r/opensource
- [ ] Post X/Twitter thread
- [ ] Post LinkedIn article
- [ ] Reply to every comment within 1 hour

### Launch day (afternoon):
- [ ] Check HN ranking — if on front page, engage in comments
- [ ] Cross-post to Dev.to or Hashnode
- [ ] Share in relevant Discord/Slack communities
- [ ] Email newsletter subscribers (Issue #3)

### Post-launch (week 1):
- [ ] Respond to every GitHub issue within 24 hours
- [ ] Thank every starrer in discussions
- [ ] Ship at least one improvement based on feedback
- [ ] Write a "lessons learned" follow-up post

---

## 7. Good First Issues (create these on GitHub)

1. **Add `cortex history` command** — show memory creation history by date
2. **Add memory export to CSV** — currently JSON only, add CSV option
3. **Dashboard: dark/light theme toggle** — add a button in the dashboard header
4. **CLI: add `cortex count` command** — quick memory count without full status
5. **Improve error message when Node < 18** — current message could be friendlier
6. **Add `--verbose` flag to more CLI commands** — currently only on doctor
7. **Dashboard: keyboard shortcuts** — Cmd+K for search, Cmd+N for new memory

---

## 8. Communities to Share In

| Community | Where | Timing |
|---|---|---|
| Hacker News | news.ycombinator.com/submit | Tuesday-Thursday, 8-9am ET |
| r/ClaudeAI | reddit.com/r/ClaudeAI | Same day as HN |
| r/programming | reddit.com/r/programming | Same day |
| r/opensource | reddit.com/r/opensource | Same day |
| X/Twitter | Thread from your account | Same day, after HN |
| LinkedIn | Personal post + K2N2 Studio page | Same day |
| Dev.to | dev.to/new | Day after launch |
| Anthropic Discord | discord.gg/anthropic | Day after launch |
| Claude Code GitHub Discussions | github.com/anthropics/claude-code | Week after (be helpful, not spammy) |
| IndieHackers | indiehackers.com | Week after |
| Product Hunt | producthunt.com | 2 weeks after (once you have traction) |

---

*Launch day target: 50+ stars in 24 hours. Week 1 target: 200+ stars.*
