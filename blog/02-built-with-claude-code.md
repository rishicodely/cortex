<!-- meta:title We Used Claude Code to Build a Memory Tool for Claude Code -->
<!-- meta:description How we built Cortex — a persistent memory layer for Claude Code — using Claude Code itself. The irony, the process, and what we learned about building MCP servers. -->
<!-- meta:keywords building with Claude Code, MCP server tutorial, how to build MCP tools, Claude Code development -->
<!-- meta:canonical https://www.theproductionline.ai/blog/built-with-claude-code -->

# We Used Claude Code to Build a Memory Tool for Claude Code

There is an obvious irony in using an amnesiac AI to build a memory system. Every morning for four weeks, I opened Claude Code, re-explained what Cortex was, what we had built so far, and what we were building next. Claude helped me write the code for a tool that would prevent exactly this problem.

By week three, the tool was functional enough to use on itself. That was a strange morning — Claude opened the session and already knew the Cortex codebase, the architecture decisions we had made, and the open threads from yesterday. No re-explanation. It just started working.

## The process

I started with a PRD. Not a vague product spec — a brutally detailed technical document covering the MCP tool interface, the quality gate rules, the database schema, the CLI command surface. Claude Code is significantly more effective when you give it a complete specification rather than iterating on a vague idea.

The build took four weeks of evenings and weekends. The monorepo has nine packages: shared types, the MCP server, the CLI, a Next.js dashboard, a SwiftUI Mac app, an Electron app, a VS Code extension, an installer package, and a marketing site. Claude Code wrote roughly 80 percent of the code. I wrote the architecture, the specifications, and the parts where Claude kept getting stuck.

## The hardest problem

The hardest problem was not the MCP protocol integration. That was straightforward — the @modelcontextprotocol/sdk handles the transport and tool registration cleanly.

The hardest problem was the quality gate.

Without a quality gate, Claude Code saves everything. It saves meta-commentary about its own process. It saves restatements of things already in the context. It saves low-quality observations that add no value. After a single session without the gate, I had 200 memories and maybe 15 of them were worth keeping.

The TF-IDF duplicate detection was particularly tricky. You cannot do a simple string comparison because Claude phrases the same idea differently each time. We needed semantic similarity, but running an embedding model locally would add latency and a large dependency. TF-IDF cosine similarity turned out to be a good middle ground — fast, no external dependencies, and catches 90 percent of duplicates at a 0.85 threshold.

The sensitive data blocker was the other hard one. Regular expressions for API key patterns sound simple until you realize there are dozens of formats: AWS keys, GitHub tokens, Stripe keys, JWTs, SSH private keys, basic auth headers. We settled on a combination of pattern matching and entropy analysis — high-entropy strings in specific contexts are almost always secrets.

## What I would do differently

I would have built the quality gate first. I spent the first two weeks building the MCP server and CLI without it, and the memory database was unusable by day three. The quality gate should have been the foundation, not the refinement.

I would also have started with fewer memory types. We launched with six (Decision, Context, Preference, Thread, Error, Learning). Three would have been enough to validate the concept: Decision, Preference, and Thread. The other three are useful but not essential for the core loop.

## What comes next

Multi-machine sync is almost ready — Turso's embedded replicas work well for this use case because every machine has a full local copy and sync happens asynchronously.

The VS Code extension is in beta. It adds a memory sidebar where you can browse, search, and manually save memories without leaving the editor.

Team sharing is on the roadmap. Shared memory spaces where an engineering team's collective decisions and conventions are available to every team member's Claude Code sessions.

Install Cortex: `npx @cortex.memory/cli init`

GitHub: https://github.com/ProductionLineHQ/cortex
