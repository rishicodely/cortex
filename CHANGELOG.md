# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Multi-machine sync via Turso (libsql) with conflict resolution
- VS Code extension with memory sidebar and inline context
- Team sharing — shared memory spaces for engineering teams
- Memory analytics — usage patterns, most-referenced memories, decay tracking
- Webhooks — trigger actions when memories are created or updated

## [1.0.0] - 2025-03-22

### Added
- MCP server with 5 tools: `cortex_get_context`, `cortex_save_memory`, `cortex_search`, `cortex_list_projects`, `cortex_get_status`
- Session summarizer — AI reviews completed sessions and captures missed context automatically
- Quality gate with 7 validation rules: content length (50-2000 chars), reason field required (min 10 chars), duplicate detection (TF-IDF similarity < 85%), banned phrase filter, sensitive data blocker (API keys, passwords, tokens, private keys), quality score threshold (3+), rate limiting (50 saves per session, 200 per day)
- 6 memory types with distinct lifecycles: Decision (permanent), Context (may expire), Preference (permanent), Thread (expires when resolved), Error (persists until fixed), Learning (permanent)
- Project detection using 4-layer strategy: git remote URL, package.json name, directory name, manual assignment
- Local SQLite database at `~/.cortex/cortex.db` with full-text search via FTS5
- 33 CLI commands: init, status, doctor, show, search, add, edit, delete, clear, export, import, backup, start, stop, restart, logs, sync status, sync push, sync pull, config show, config set, config reset, uninstall, version, help, count, history, stats, tag, untag, pin, unpin, archive
- Web dashboard (Next.js 14) on localhost:7433 with memory browsing, search, bulk operations, project switching, and sync status
- `cortex doctor` diagnostic command — checks daemon health, database integrity, MCP registration, and configuration
- Clean uninstall via `cortex uninstall` — removes database, daemon, config, and MCP registration with optional memory export
- AES-256-GCM encryption for stored credentials (Turso tokens, sync keys)
- Homebrew tap for macOS installation (`brew install cortex-memory`)
- npx one-command setup (`npx @cortex.memory/cli init`)
- curl install script for automated environments
- Electron desktop app with system tray integration
- SwiftUI native macOS app (macOS 13+)
- Zero telemetry by default — no analytics, no crash reporting, no phone-home

This project adheres to [Semantic Versioning](https://semver.org/) and [Keep a Changelog](https://keepachangelog.com/).
