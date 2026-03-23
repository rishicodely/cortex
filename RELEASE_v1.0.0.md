# Cortex v1.0.0

Cortex is a persistent memory layer for Claude Code. It runs as a local MCP server that captures decisions, context, and preferences during your coding sessions, validates them through a quality gate, and injects them back into every future session. Claude Code starts every conversation knowing exactly where you left off.

This is the initial public release. Everything described below ships today and is production-ready.

## What ships in v1.0.0

**MCP Server** with 5 tools exposed to Claude Code via the Model Context Protocol:
- `cortex_get_context` — read project memories at session start
- `cortex_save_memory` — save a new memory with type, content, and importance
- `cortex_search` — full-text search across all projects
- `cortex_list_projects` — list projects with memory counts
- `cortex_get_status` — daemon health and memory statistics

**6 memory types** with distinct lifecycles: Decision (permanent architectural choices), Context (project status, may expire), Preference (coding style rules, permanent), Thread (open investigations, expires when resolved), Error (bugs, persists until fixed), Learning (discovered insights, permanent).

**Quality gate** with 7 validation rules that prevent the database from filling with noise:
1. Content length bounds (50–2000 characters)
2. Reason field required (minimum 10 characters)
3. Duplicate detection (TF-IDF cosine similarity < 85%)
4. Banned phrase filter (blocks meta-commentary)
5. Sensitive data blocker (rejects API keys, passwords, tokens)
6. Quality score threshold (minimum 3/10 for specificity)
7. Rate limiting (50 saves per session, 200 per day)

**Session summarizer** — AI reviews completed sessions and captures context that was discussed but not explicitly saved. Runs the same quality gate on generated memories.

**33 CLI commands** covering project management (init, status, doctor), memory operations (show, search, add, edit, delete, clear, tag, pin, archive), data management (export, import, backup), daemon control (start, stop, restart, logs), sync (status, push, pull, setup), and configuration.

**Web dashboard** on localhost:7433 — browse, search, edit, delete, and export memories visually. Project switching, memory type filtering, bulk operations, and sync status.

**Project detection** using a 4-layer strategy: git remote URL, package.json name, directory name, or manual assignment.

**Local SQLite** storage at `~/.cortex/cortex.db` with full-text search via FTS5. WAL mode for concurrent reads. Zero external dependencies for storage.

**Clean uninstall** via `cortex uninstall` — removes database, daemon, config, and MCP registration with optional memory export.

## Install

```bash
# Homebrew (macOS)
brew tap ProductionLineHQ/cortex && brew install cortex-memory

# npx (any platform)
npx @cortex.memory/cli init

# curl
curl -fsSL https://raw.githubusercontent.com/ProductionLineHQ/cortex/main/scripts/install.sh | sh
```

## What's next

- **Multi-machine sync** via Turso (libsql) — in progress, shipping in v1.1
- **VS Code extension** — memory sidebar, inline context, quick save from editor (beta)
- **Team sharing** — shared memory spaces for engineering teams
- **Memory analytics** — usage patterns, most-referenced memories, decay tracking

## Links

- Product page: https://www.theproductionline.ai/tools/cortex
- Documentation: https://github.com/ProductionLineHQ/cortex/tree/main/docs
- npm: https://www.npmjs.com/package/@cortex.memory/cli

Built by [Koundinya Lanka](https://github.com/koundinyalanka) at [The Production Line](https://www.theproductionline.ai).
