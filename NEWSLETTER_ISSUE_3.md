# Issue #3 — Cortex: I Built Persistent Memory for Claude Code

## Subject line options:
1. "I built the tool I wished existed for Claude Code"
2. "Claude Code finally remembers (open source)"
3. "Cortex: persistent memory for Claude Code — free for subscribers"

---

## Opening

Every morning, I open Claude Code and explain my architecture again. The same NestJS setup. The same TypeScript preferences. The same open threads from yesterday. It's like training a brilliant contractor who gets amnesia overnight.

Context windows are getting bigger. Models are getting smarter. But session memory? Still zero. You close a tab, the context dies. You switch machines, the context dies. You take a lunch break that runs long enough for the session to expire — the context dies. I got tired of re-explaining myself to the smartest coding tool I've ever used. So I built Cortex.

## What Cortex Does

- **Runs as a local daemon alongside Claude Code.** A lightweight background service that stays out of your way. No cloud dependency, no account signup, no telemetry.
- **Captures decisions, preferences, and context as structured memories.** Every architecture decision, every "we tried X and it didn't work," every preference you have about code style — saved once, remembered forever.
- **Injects relevant memories at session start via MCP.** When Claude Code starts, Cortex feeds it the memories that matter for your current project through the Model Context Protocol. Claude doesn't just know your codebase — it knows your thinking.
- **Optional multi-machine sync via Turso.** Work on your desktop at the office and your laptop at the coffee shop. Same memories, same context, same continuity. You own the database.

## The Demo

Here's what happens now: I open Claude Code on my MacBook Air — a machine I haven't used in a week. I type "morning, let's continue." Claude responds with full context: the Fastify migration decision, the Deepgram latency thread, the deployment blockers. No re-explaining. No context dump. It just knows.

The first time this happened, I sat there for a few seconds staring at the terminal. It felt like the machine finally respected my time. That's the magic moment — not a feature demo, not a benchmark. Just the feeling that your tools actually work *with* you instead of making you repeat yourself.

## Install (subscriber exclusive)

```bash
npx @cortex-memory/cli init
```

One command. 30 seconds. That's it.

It detects your shell, creates the config directory, starts the daemon, and registers the MCP server with Claude Code. You'll see a confirmation in your terminal and you're done. Next time you open Claude Code, Cortex is there.

## What's Inside

This isn't a weekend hack. Cortex is a production-grade tool with real engineering behind it:

- **30+ CLI commands** — full CRUD for memories, sessions, threads, config, and sync
- **Web dashboard at localhost:7434** — browse, search, and manage memories visually
- **VS Code extension** — save memories from your editor without leaving your flow
- **Native SwiftUI Mac app** — menubar access with quick-capture and status
- **Session summarizer** — AI reviews completed sessions and extracts key decisions automatically
- **Quality gate** — 6 rules prevent garbage memories from polluting your context (duplicate detection, minimum content length, relevance scoring)
- **85+ tests, 7 docs, MIT licensed** — this is open source you can actually trust in your stack

## Architecture for the Curious

For those who want to know what's under the hood:

- **TypeScript monorepo** — 9 packages managed with pnpm workspaces. Shared types, shared validation, zero version drift.
- **SQLite via better-sqlite3** — local-first storage. Your memories never leave your machine unless you opt into sync. No external database to provision.
- **Fastify REST API + SSE** — the daemon exposes a clean API. Server-Sent Events for real-time updates to the dashboard and extensions.
- **MCP protocol integration** — native support for Anthropic's Model Context Protocol. Cortex registers as a tool provider that Claude Code queries automatically.
- **AES-256-GCM encrypted credentials** — sync tokens, API keys, anything sensitive is encrypted at rest. Not base64'd. Actually encrypted.
- **Turso for multi-machine sync** — when you want memories to follow you across devices, Turso's embedded replicas give you local-speed reads with cloud sync. You provision the database, you own the data.

The entire system is designed around one principle: your context is yours. It lives on your machine, it's stored in a format you can inspect and export, and no part of the system phones home.

## Open Source

Full source: [github.com/ProductionLineHQ/cortex](https://github.com/ProductionLineHQ/cortex)

Star it, fork it, contribute. Good first issues are tagged and waiting. The codebase is well-documented — every package has a README, every public function has JSDoc, and the architecture doc explains why decisions were made, not just what they are.

## What's Next

- **v1.1: Semantic search with embeddings** — find memories by meaning, not just keywords. "What did we decide about authentication?" will surface the right memory even if you never used the word "auth."
- **v1.2: Team memory sharing** — opt-in shared memory pools for teams. Onboard new engineers with the accumulated context of the entire project.
- **v1.3: Custom memory rules** — define your own quality gates and auto-capture rules. "Always save architectural decisions." "Never save TODOs that are resolved within the same session."

---

## Closing

Cortex is the first tool from The Production Line — and it won't be the last. Every issue of this newsletter ships something real. Not theory. Not frameworks. Working tools that make your engineering workflow better.

If you use Claude Code, try Cortex. If you don't, forward this to someone who does. And if you build something cool with it — reply to this email. I read every one.

— Koundinya
