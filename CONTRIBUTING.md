# Contributing to Cortex

Thanks for your interest in contributing. This guide covers everything you need to get started.

## Development Setup

```bash
# Clone the repo
git clone https://github.com/ProductionLineHQ/cortex.git
cd cortex

# Install dependencies (requires pnpm 9+)
pnpm install

# Build all packages
pnpm build

# Run the test suite
pnpm test

# Start the dev server (daemon + dashboard with hot reload)
pnpm dev
```

Requirements: Node.js 18+, pnpm 9+.

## Repo Structure

This is a pnpm monorepo managed with Turborepo. Here are the packages:

| Package | Path | What it does |
|---------|------|-------------|
| `@cortex.memory/shared` | `packages/shared` | Shared types, schemas (Zod), constants, utilities |
| `@cortex.memory/server` | `packages/server` | MCP server, REST API (Fastify), quality gate, summarizer, SQLite |
| `@cortex.memory/cli` | `packages/cli` | CLI tool (33 commands), project detection, daemon management |
| `dashboard` | `packages/dashboard` | Next.js 14 web dashboard (localhost:7433) |
| `desktop` | `packages/desktop` | SwiftUI native macOS app |
| `electron` | `packages/electron` | Electron desktop app (cross-platform) |
| `vscode` | `packages/vscode` | VS Code extension |
| `installer` | `packages/installer` | Homebrew formula, install scripts |
| `web` | `packages/web` | Marketing site |

## Running Cortex Locally

```bash
# Build everything first
pnpm build

# Start the daemon in dev mode (auto-restarts on changes)
pnpm --filter @cortex.memory/server dev

# In a separate terminal, start the dashboard
pnpm --filter dashboard dev

# The MCP server runs on localhost:7434
# The dashboard runs on localhost:7433
```

To test the full flow with Claude Code, register the dev MCP server:

```bash
# Point Claude Code to your local dev server
pnpm --filter @cortex.memory/cli dev -- init --dev
```

## Running Tests

```bash
# Run all tests
pnpm test

# Run tests for a specific package
pnpm --filter @cortex.memory/server test

# Run tests in watch mode
pnpm --filter @cortex.memory/server test -- --watch

# Run tests with coverage
pnpm test:coverage
```

We use Vitest. Tests live next to the code they test (`*.test.ts`).

## Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/). Every commit message must follow this format:

```
type(scope): description

[optional body]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`

Scope is the package name without the org prefix: `server`, `cli`, `shared`, `dashboard`, `vscode`, `electron`.

Examples:
```
feat(cli): add cortex history command
fix(server): handle empty memory content in quality gate
docs(readme): update install instructions for Windows
refactor(shared): extract memory type validation to separate module
```

## PR Process

1. **Open an issue first** for anything non-trivial. This lets us discuss the approach before you write code. Bug fixes and typo corrections can skip this step.

2. **Fork and branch.** Create a branch from `main` with a descriptive name: `feat/history-command`, `fix/quality-gate-empty-content`.

3. **Write tests.** New features need tests. Bug fixes need a test that would have caught the bug.

4. **Run the checks** before pushing:
   ```bash
   pnpm lint
   pnpm typecheck
   pnpm test
   ```

5. **Open the PR.** Fill out the PR template. Link to the issue. Describe how to test it.

6. **Respond to review.** We aim to review PRs within 48 hours. Push changes as new commits, not force-pushes, so reviewers can see what changed.

## Code Style

- TypeScript strict mode. No `any` unless absolutely necessary and justified in a comment.
- ESM imports only. No CommonJS `require()`.
- Zod for all runtime validation (API inputs, config files, MCP tool parameters).
- Small, pure functions. If a function does more than one thing, split it.
- No abbreviations in variable names. `memoryContent` not `memCont`.

ESLint and Prettier configs are provided. Run `pnpm lint` before committing. Your editor should pick up the config automatically.

## Decision Making

For anything that changes the public API, the data model, or the architecture:

1. Open a GitHub issue describing the problem and your proposed solution.
2. Wait for a maintainer to respond. We will discuss trade-offs and agree on an approach.
3. Once agreed, reference the issue in your PR.

This prevents surprises and duplicate work. Small fixes, documentation improvements, and test additions do not need this process.

## Questions?

Open a [GitHub Discussion](https://github.com/ProductionLineHQ/cortex/discussions) or file an issue. We respond to everything.
