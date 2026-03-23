# Launch Playbook — Cortex v1.0.0

> Internal document. Copy-paste these posts on launch day.

---

## 1. Show HN (Hacker News)

**Title:**
```
Show HN: Cortex – Persistent memory for Claude Code (open source, local-first)
```

**First comment (post this immediately after submitting):**

I built Cortex because I was spending the first 20 minutes of every Claude Code session re-explaining my project. Architecture decisions I made last week, naming conventions, why I chose one library over another — all gone. Every morning, blank slate.

Cortex is a local MCP server that runs alongside Claude Code. During a session, it captures decisions, preferences, and context as structured memories. Next session, it injects the relevant ones back automatically. Claude starts every conversation knowing where you left off.

The interesting engineering problem was the quality gate. Without it, the memory database fills up with noise — "I will now implement the function" is not a useful memory. So every save passes through 7 validation rules: content length bounds, duplicate detection using TF-IDF cosine similarity, a sensitive data blocker (rejects API keys, passwords, tokens), a quality scorer that checks for specificity and technical content, and rate limiting. The quality gate is the reason this works in practice and not just in demos.

Architecture: TypeScript monorepo, SQLite via better-sqlite3 on your machine, Fastify REST API, MCP protocol for the Claude Code integration. Optional Turso sync for multi-machine setups — you create the database, you own the credentials. Nothing goes through our servers.

I am looking for feedback on two things: (1) are the default quality gate thresholds right, or do they reject too much / too little? (2) what memory types am I missing beyond the current six (Decision, Context, Preference, Thread, Error, Learning)?

Install: `npx @cortex.memory/cli init`

Repo: https://github.com/ProductionLineHQ/cortex

---

## 2. Reddit r/ClaudeAI

**Title:**
```
I built an open-source persistent memory layer for Claude Code — it remembers your decisions, preferences, and context across every session
```

**Body:**

I have been using Claude Code as my primary coding tool for the past few months. It is genuinely good at writing code. But every session starts from zero. I would explain my architecture, my conventions, why I made certain decisions — and the next morning I would do it all again.

So I built Cortex. It runs as a local MCP server alongside Claude Code and does two things:

1. During a session, it captures decisions, preferences, and context as structured memories
2. At the start of every new session, it injects the relevant memories back

The result: Claude starts every conversation knowing your project. No re-explaining, no pasting old conversations, no context files.

A few things that matter to this community:

- It is local-first. SQLite on your machine. Nothing leaves unless you opt into sync.
- There is a quality gate (7 rules) that prevents garbage from being stored. It blocks duplicates, sensitive data, and low-quality content.
- 33 CLI commands and a web dashboard for managing everything.
- One command install: `npx @cortex.memory/cli init`
- Open source, MIT licensed.

Honest limitations: it does not work with the Claude web interface, only Claude Code (the CLI/IDE tool). The summarizer sometimes misses context. And the quality gate is opinionated — you might disagree with the thresholds.

Repo: https://github.com/ProductionLineHQ/cortex

What context do you find yourself re-explaining the most? I want to make sure the memory types cover the right categories.

---

## 3. Reddit r/LocalLLaMA

**Title:**
```
Open-source persistent memory for Claude Code — local SQLite, no cloud, nothing leaves your machine
```

**Body:**

For those who care about local-first AI tooling: I built a persistent memory layer for Claude Code that stores everything locally.

How it works: Cortex runs as a local daemon on your machine. It provides tools to Claude Code via the MCP protocol. During your coding session, it captures architectural decisions, coding preferences, project context — and stores them in a local SQLite database at `~/.cortex/cortex.db`.

Next session, Claude Code reads the relevant memories and starts fully informed. No re-explaining your project.

Privacy model:

- All storage is local SQLite. No remote database.
- MCP server binds to localhost only. No external connections.
- Zero telemetry. No analytics, no crash reporting, no phone-home.
- Quality gate blocks API keys, passwords, and tokens from being stored.
- Optional multi-machine sync uses Turso — but you create the database and own the credentials. We never see your data.
- Clean uninstall removes everything: `cortex uninstall`

One command install: `npx @cortex.memory/cli init`

TypeScript, MIT licensed, 9 packages in a pnpm monorepo.

Repo: https://github.com/ProductionLineHQ/cortex

---

## 4. Product Hunt

**Tagline (60 chars):**
```
Persistent memory for Claude Code. Open source.
```

**Description (260 chars):**
```
Claude Code forgets everything between sessions. Cortex fixes that. Local MCP server that captures decisions, context, and preferences — and injects them back automatically. Local-first SQLite, quality-gated, open source.
```

**Maker's first comment (300 words):**

I built Cortex because I was tired of starting every Claude Code session from scratch.

Claude Code is the best AI coding tool I have used. But it has a fundamental limitation: no persistent memory. Every session starts from zero. Your architecture decisions from last week, your coding conventions, the bug you were investigating — all gone.

For the past three months, I found myself spending the first 15 to 20 minutes of every session re-explaining context. That is roughly 6 hours a month of wasted time, just re-establishing what the AI should already know.

Cortex is a local MCP server that solves this. It runs alongside Claude Code and does two things: captures important context during your sessions (decisions, preferences, open threads), and injects the relevant memories back at the start of every future session.

The hardest part was the quality gate. Without it, the memory database fills up with noise. So every memory passes through 7 validation rules — content length, duplicate detection, sensitive data blocking, quality scoring, and rate limiting. This is what separates Cortex from "just save everything to a text file."

Technical details for those interested: TypeScript monorepo, SQLite via better-sqlite3, MCP protocol for Claude Code integration, Fastify REST API, Next.js dashboard, 33 CLI commands. Everything runs on your machine. Nothing leaves unless you opt into Turso sync.

What is next: multi-machine sync is almost ready, the VS Code extension is in beta, and team sharing (shared memory spaces for engineering teams) is on the roadmap for Q2.

It is open source and MIT licensed. Install with one command: `npx @cortex.memory/cli init`

I would love your feedback on what memory types are missing and whether the quality gate thresholds feel right.

---

## 5. X/Twitter Thread

```
1/ I just open-sourced Cortex — persistent memory for Claude Code.

Every session starts from zero. Cortex fixes that.

One command: npx @cortex.memory/cli init

github.com/ProductionLineHQ/cortex

2/ The problem:

Claude Code is brilliant at coding. But it has amnesia.

Every morning you re-explain your architecture, your preferences, your conventions. It is like hiring a genius contractor who forgets everything overnight.

3/ How Cortex works:

- Runs as a local daemon on localhost:7434
- Provides MCP tools to Claude Code
- Captures decisions, preferences, context as structured memories
- Injects relevant memories at session start

Your AI starts every conversation fully informed.

4/ The quality gate is what makes it work:

7 rules. Every memory must pass:
- Length (50-2000 chars)
- No banned phrases
- No sensitive data (API keys, passwords)
- Quality score (specificity, technical terms)
- No duplicates (TF-IDF similarity check)
- Rate limit (50/session, 200/day)
- Reason field required

5/ Local-first architecture:

- SQLite on your machine
- Nothing leaves unless YOU enable sync
- Turso sync = your database, your account
- We never see your memories
- AES-256-GCM encrypted credentials
- Zero telemetry by default

6/ What you get:

- MCP server with 5 tools
- 6 memory types (Decision, Context, Preference, Thread, Error, Learning)
- 33 CLI commands
- Next.js web dashboard
- Session summarizer
- Quality gate
- Multi-machine sync (coming)

7/ It is MIT licensed and fully open source.

If you use Claude Code, give it a try:

npx @cortex.memory/cli init

github.com/ProductionLineHQ/cortex
```

---

## 6. LinkedIn Post

```
I just open-sourced Cortex — a persistent memory layer for Claude Code.

The problem: Claude Code starts every session from zero. No memory of previous conversations, no awareness of past decisions, no knowledge of your preferences.

For engineering teams, this means 15 to 30 minutes per developer per day re-establishing context. For a team of 10, that is 2.5 to 5 hours of lost productivity every single day.

Cortex fixes this by running a local daemon that captures decisions, preferences, and context as structured memories — then silently injects them into every new session.

Key principles:
- Local-first: SQLite on your machine, nothing leaves unless you enable sync
- Quality-gated: 7-rule engine prevents low-quality or duplicate memories
- Privacy-respecting: zero telemetry, you own your data, clean uninstall
- One command install: npx @cortex.memory/cli init

For CTOs and engineering leaders: this is the tool that makes your team's AI investment compound over time instead of resetting every morning.

Open source (MIT): https://github.com/ProductionLineHQ/cortex
Product page: https://www.theproductionline.ai/tools/cortex
```

---

## 7. Launch Day Checklist

### Pre-launch (day before):
- [ ] Verify repo looks good on GitHub (README renders, badges work, topics set)
- [ ] Set repo description and topics from GITHUB_METADATA.md
- [ ] Upload social preview image (use /api/og/cortex screenshot)
- [ ] Enable GitHub Discussions
- [ ] Create 5 "good first issue" labels with real issues
- [ ] Star your own repo
- [ ] Tweet a teaser: "Shipping something tomorrow for Claude Code users..."

### Launch day (morning, 8-9am ET Tuesday-Thursday):
- [ ] Submit to Hacker News (Show HN)
- [ ] Post the first comment immediately after HN submission
- [ ] Post to r/ClaudeAI
- [ ] Post to r/LocalLLaMA
- [ ] Post X/Twitter thread
- [ ] Post LinkedIn
- [ ] Reply to every comment within 1 hour

### Launch day (afternoon):
- [ ] Check HN ranking — if on front page, engage in comments
- [ ] Post to r/programming and r/opensource
- [ ] Email newsletter subscribers (Issue #3)
- [ ] Share in Anthropic Discord

### Post-launch (week 1):
- [ ] Respond to every GitHub issue within 24 hours
- [ ] Ship at least one improvement based on feedback
- [ ] Submit to Product Hunt (once you have 50+ stars)
- [ ] Write a Dev.to article: "I Built Persistent Memory for Claude Code — Here's the Architecture"

### Good First Issues (create these before launch):
1. Add `cortex history` command — show memory creation history by date
2. Add memory export to CSV — currently JSON only
3. Dashboard: dark/light theme toggle
4. CLI: add `cortex count` command — quick memory count
5. Improve error message when Node < 18
6. Add `--verbose` flag to more CLI commands
7. Dashboard: keyboard shortcuts (Cmd+K for search)
