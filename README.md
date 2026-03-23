# C●rtex

**Persistent memory for Claude Code. Install once, never re-explain your project again.**

Claude Code forgets everything between sessions. Your architecture, your preferences, every decision you made yesterday — gone. Cortex is a local MCP server that captures context during your sessions and feeds it back automatically. Your AI starts every conversation knowing exactly where you left off.

<p align="center">
  <img src="assets/cortex-demo.gif" alt="Cortex demo — install, status, show memories, search" width="100%">
</p>

<p align="center">
  <a href="https://www.theproductionline.ai/tools/cortex"><strong>Product Page</strong></a> &nbsp;·&nbsp;
  <a href="https://www.npmjs.com/package/@cortex.memory/cli"><strong>npm</strong></a> &nbsp;·&nbsp;
  <a href="https://github.com/ProductionLineHQ/cortex/issues"><strong>Issues</strong></a> &nbsp;·&nbsp;
  <a href="https://www.theproductionline.ai/tools/cortex"><strong>Docs</strong></a>
</p>

<p align="center">
  <a href="https://github.com/ProductionLineHQ/cortex/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/ProductionLineHQ/cortex/ci.yml?label=CI&logo=github" alt="CI"></a>
  <a href="https://www.npmjs.com/package/@cortex.memory/cli"><img src="https://img.shields.io/npm/v/@cortex.memory/cli?color=cb3837&label=npm&logo=npm" alt="npm version"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/ProductionLineHQ/cortex/stargazers"><img src="https://img.shields.io/github/stars/ProductionLineHQ/cortex?style=social" alt="GitHub Stars"></a>
  <a href="https://www.theproductionline.ai/tools/cortex"><img src="https://img.shields.io/badge/Website-theproductionline.ai-7C6FE0" alt="Website"></a>
</p>

---

If Cortex is useful to you, a star helps other engineers find it.

---

## The Problem

Claude Code forgets context between sessions. Every conversation starts from zero. You explain your architecture, your naming conventions, the tech stack, why you chose Turso over PlanetScale — and tomorrow it asks the same questions again. Claude Code loses context when the session ends, completely.

For most engineers, this means 15 to 30 minutes of wasted context-setting every morning. You are paying for a genius contractor who forgets everything overnight. There is no built-in way to give Claude Code persistent memory. Session memory disappears the moment you close the terminal. If you have searched for how to give Claude Code memory that persists across sessions, you have found the right tool.

Cortex is an MCP server that provides context persistence for Claude Code. It runs silently in the background, captures the decisions and preferences that matter, and injects them back at the start of every future session. No manual note-taking, no pasting old conversations, no context files you have to maintain. Your AI coding assistant finally has memory between sessions.

## Install

Three ways. Pick one.

**Homebrew (macOS)**
```bash
brew tap ProductionLineHQ/cortex
brew install cortex-memory
```

**npx (any platform)**
```bash
npx @cortex.memory/cli init
```

**curl**
```bash
curl -fsSL https://raw.githubusercontent.com/ProductionLineHQ/cortex/main/scripts/install.sh | sh
```

After install, run `cortex init` in any project directory. Cortex registers itself as an MCP server with Claude Code automatically.

## How It Works

Cortex runs as a local daemon on your machine. It connects to Claude Code through the Model Context Protocol, the same interface Claude Code uses for all its tool integrations.

```
┌──────────────┐     MCP Protocol     ┌───────────────┐
│  Claude Code  │◄───────────────────►│  Cortex MCP   │
│  (your IDE)   │   read/write tools  │    Server      │
└──────────────┘                      └───────┬───────┘
                                              │
                                      ┌───────▼───────┐
                                      │  Quality Gate  │
                                      │  (7 rules)     │
                                      └───────┬───────┘
                                              │
                                      ┌───────▼───────┐
                                      │    SQLite      │
                                      │  (local disk)  │
                                      └───────┬───────┘
                                              │ optional
                                      ┌───────▼───────┐
                                      │  Turso Sync    │
                                      │ (multi-machine)│
                                      └───────────────┘
```

When Claude Code starts a session, it calls the `cortex_get_context` MCP tool. Cortex returns the relevant memories for the current project:

```json
{
  "tool": "cortex_get_context",
  "result": {
    "project": "my-saas-app",
    "memories": [
      {
        "type": "decision",
        "content": "Using Drizzle ORM instead of Prisma — better edge runtime support and no binary dependency",
        "importance": 8,
        "created": "2025-03-19T14:22:00Z"
      },
      {
        "type": "preference",
        "content": "Always use server components by default, only add use client when state or effects are needed",
        "importance": 9,
        "created": "2025-03-18T09:15:00Z"
      },
      {
        "type": "thread",
        "content": "Investigating WebSocket reconnection drops under high load — suspect Cloudflare timeout at 100s",
        "importance": 7,
        "created": "2025-03-20T16:40:00Z"
      }
    ]
  }
}
```

During the session, Claude can save new memories through the `cortex_save_memory` tool. Every memory passes through a quality gate before being stored — this prevents the database from filling up with noise.

At the end of each session, an AI summarizer reviews the conversation for any important context that Claude forgot to save, and captures those as additional memories.

## Features

| Feature | Description |
|---------|-------------|
| **MCP Server** | 5 tools exposed to Claude Code via the Model Context Protocol |
| **6 Memory Types** | Decision, Context, Preference, Thread, Error, Learning — each with its own lifecycle |
| **Quality Gate** | 7 validation rules block duplicates, sensitive data, and low-quality saves |
| **Session Summarizer** | AI reviews completed sessions and captures missed context |
| **Project Detection** | 4-layer strategy (git remote → package.json → directory name → manual) |
| **33 CLI Commands** | Full terminal interface for browsing, searching, editing, and exporting memories |
| **Web Dashboard** | Next.js dashboard on localhost:7433 — search, filter, edit, bulk operations |
| **Multi-Machine Sync** | Optional Turso-powered sync across your machines (you own the database) |
| **VS Code Extension** | Memory sidebar, inline context, quick save from the editor |
| **Desktop App** | Native Electron app with system tray integration |
| **Local First** | SQLite on your machine. Nothing leaves unless you enable sync |
| **Clean Uninstall** | `cortex uninstall` removes everything — database, daemon, config, MCP registration |

## Configuration

Cortex works out of the box with zero configuration. For those who want to customize:

```bash
# Show current configuration
cortex config show

# Set custom MCP server port (default: 7434)
cortex config set port 7434

# Set dashboard port (default: 7433)
cortex config set dashboard.port 7433

# Enable multi-machine sync
cortex config set sync.enabled true
cortex config set sync.url libsql://your-db.turso.io
cortex config set sync.token your-turso-auth-token

# Adjust quality gate thresholds
cortex config set quality.minLength 50
cortex config set quality.maxLength 2000
cortex config set quality.similarityThreshold 0.85
cortex config set quality.rateLimit.perSession 50
```

Configuration is stored in `~/.cortex/config.json`. Project-specific overrides go in `.cortex/config.json` in your project root.

## CLI Reference

```bash
# Project management
cortex init                    # Initialize Cortex in the current project
cortex status                  # Show daemon status, memory counts, sync state
cortex doctor                  # Diagnose and fix common issues

# Memory operations
cortex show [project]          # Browse memories for a project
cortex search <query>          # Full-text search across all projects
cortex add                     # Manually add a memory
cortex edit <id>               # Edit an existing memory
cortex delete <id>             # Delete a memory
cortex clear [project]         # Delete all memories (with backup prompt)

# Data management
cortex export [project]        # Export memories as JSON
cortex import <file>           # Import memories from a JSON file
cortex backup                  # Create a timestamped database backup

# Daemon control
cortex start                   # Start the background daemon
cortex stop                    # Stop the daemon
cortex restart                 # Restart the daemon
cortex logs                    # View daemon logs

# Sync
cortex sync status             # Show sync state
cortex sync push               # Push local changes to Turso
cortex sync pull               # Pull remote changes

# Utilities
cortex config show             # Show configuration
cortex config set <key> <val>  # Update a config value
cortex uninstall               # Remove Cortex completely (with export option)
cortex --version               # Print version
```

Run `cortex help <command>` for detailed usage of any command.

## FAQ

**Does this send my code to your servers?**

No. Cortex runs entirely on your machine. The MCP server listens on localhost only — it is one of the few MCP tools for context persistence that is fully local. Your memories are stored in a SQLite database at `~/.cortex/cortex.db`. The only time data leaves your machine is if you explicitly enable Turso sync, and even then, you create the database yourself and own the credentials. We never see your data.

**What happens if I uninstall?**

Run `cortex uninstall`. It removes the database, stops the daemon, deletes the config directory, and unregisters the MCP server from Claude Code. Before deletion, it offers to export all your memories to a JSON file. Nothing is left behind. If you installed via Homebrew, also run `brew uninstall cortex-memory`. Your Claude Code project context across sessions is exported as JSON so nothing is lost.

**Does it work with projects that don't use git?**

Yes. Cortex uses a 4-layer project detection strategy: git remote URL (most reliable), package.json name field, directory name, or manual assignment via `cortex init --name my-project`. Git is preferred for consistent project identification but is not required. The goal is to give every project its own persistent memory space regardless of your version control setup.

**How is this different from just keeping a notes file?**

A notes file requires you to remember to write things down, to organize them, and to paste them into every Claude Code session. Cortex captures context automatically during your normal workflow, validates it through a quality gate, categorizes it by type, and injects it into Claude Code without you doing anything. It also handles deduplication, expiration, importance scoring, and cross-project search — things a text file cannot do.

**Will this slow down Claude Code?**

No. The MCP server runs as a separate process on localhost. Context injection adds roughly 50 to 100 milliseconds to session startup — the time it takes to read from SQLite and format the response. Memory saves happen asynchronously and do not block your session. The quality gate and summarizer run after your session ends.

**Can I see what's been stored?**

Yes. Run `cortex show` to browse all memories for the current project, or `cortex search <query>` to find specific memories across all projects. The web dashboard at `localhost:7433` gives you a visual interface to browse, edit, delete, and export everything. Every memory includes its type, importance score, creation date, and tags. Nothing is hidden.

## Used by

Teams and engineers using Cortex on production codebases.

| Who | Stack | Memories |
|-----|-------|----------|
| *Your project here* | — | — |

Using Cortex? Open a PR to add yourself, or share your setup on [Twitter/X with #cortexmemory](https://twitter.com/intent/tweet?text=Using%20Cortex%20for%20persistent%20Claude%20Code%20memory%20%23cortexmemory&url=https://github.com/ProductionLineHQ/cortex).

## Contributing

We welcome contributions from anyone. See [CONTRIBUTING.md](CONTRIBUTING.md) for the full guide covering dev setup, repo structure, testing, and PR process.

Quick start for contributors:

```bash
git clone https://github.com/ProductionLineHQ/cortex.git
cd cortex
pnpm install
pnpm build
pnpm test
```

The monorepo has 9 packages: `shared`, `server`, `cli`, `dashboard`, `desktop`, `electron`, `vscode`, `installer`, `web`. Each package has its own README with package-specific details.

Please open an issue before starting work on anything non-trivial. This lets us coordinate and avoids duplicate effort.

## License

MIT — [The Production Line](https://www.theproductionline.ai/tools/cortex)

Built by [Koundinya Lanka](https://github.com/koundinyalanka).
