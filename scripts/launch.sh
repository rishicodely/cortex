#!/bin/bash
# ═══════════════════════════════════════════════════════
# CORTEX LAUNCH SCRIPT
# Run this once to publish everything and go live.
# ═══════════════════════════════════════════════════════

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
DIM='\033[0;90m'
NC='\033[0m'

pass() { echo -e "${GREEN}✓${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; exit 1; }
info() { echo -e "${DIM}·${NC} $1"; }
warn() { echo -e "${YELLOW}⚡${NC} $1"; }
header() { echo -e "\n${YELLOW}═══ $1 ═══${NC}\n"; }

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

echo ""
echo "  ╔═══════════════════════════════════════╗"
echo "  ║     CORTEX v1.0.0 — LAUNCH SCRIPT     ║"
echo "  ╚═══════════════════════════════════════╝"
echo ""

# ── Pre-flight checks ──
header "PRE-FLIGHT CHECKS"

# Check npm login
if npm whoami 2>/dev/null; then
  pass "npm: logged in as $(npm whoami)"
else
  warn "npm: not logged in"
  echo "  Run: npm login"
  echo "  Then re-run this script."
  exit 1
fi

# Check gh CLI
if gh auth status 2>/dev/null | grep -q "Logged in"; then
  pass "GitHub CLI: authenticated"
else
  warn "GitHub CLI: not authenticated"
  echo "  Run: gh auth login"
  exit 1
fi

# Check build
header "BUILD"
info "Building all packages..."
pnpm install --no-frozen-lockfile 2>&1 | tail -1
pnpm --filter @cortex/shared build 2>&1 | tail -1
pnpm --filter @cortex/server build 2>&1 | tail -1
pnpm --filter @cortex/cli build 2>&1 | tail -1
pass "All packages built"

# ── Step 1: Publish to npm ──
header "STEP 1: NPM PUBLISH"

info "Publishing @cortex.memory/shared..."
cd packages/shared
npm publish --access public 2>&1 | tail -3
pass "@cortex.memory/shared published"
cd "$REPO_ROOT"

info "Publishing @cortex.memory/server..."
cd packages/server
npm publish --access public 2>&1 | tail -3
pass "@cortex.memory/server published"
cd "$REPO_ROOT"

info "Publishing @cortex.memory/cli..."
cd packages/cli
npm publish --access public 2>&1 | tail -3
pass "@cortex.memory/cli published"
cd "$REPO_ROOT"

# ── Step 2: Verify npm install works ──
header "STEP 2: VERIFY NPM INSTALL"
info "Testing: npx @cortex.memory/cli --version"
NPM_VERSION=$(npx --yes @cortex.memory/cli --version 2>/dev/null || echo "FAILED")
if [ "$NPM_VERSION" = "FAILED" ]; then
  fail "npx install failed — check npm publish output above"
else
  pass "npx works: v${NPM_VERSION}"
fi

# ── Step 3: Compute Homebrew SHA ──
header "STEP 3: HOMEBREW SHA"
info "Downloading tarball from npm..."
TARBALL_URL=$(npm view @cortex.memory/cli dist.tarball 2>/dev/null)
if [ -n "$TARBALL_URL" ]; then
  curl -sO "$TARBALL_URL"
  TARBALL_FILE=$(basename "$TARBALL_URL")
  SHA=$(shasum -a 256 "$TARBALL_FILE" | cut -d' ' -f1)
  rm -f "$TARBALL_FILE"
  pass "SHA256: $SHA"

  # Update formula
  sed -i '' "s/PLACEHOLDER_SHA256_COMPUTE_AFTER_NPM_PUBLISH/$SHA/" packages/installer/homebrew/cortex.rb
  pass "Homebrew formula updated with SHA256"
else
  warn "Could not get tarball URL — update SHA manually later"
fi

# ── Step 4: Create GitHub Release ──
header "STEP 4: GITHUB RELEASE"
info "Creating v1.0.0 release..."
gh release create v1.0.0 \
  --repo ProductionLineHQ/cortex \
  --title "Cortex v1.0.0 — Persistent Memory for Claude Code" \
  --notes "$(cat <<'NOTES'
## 🧠 Cortex v1.0.0

The first release of Cortex — persistent memory for Claude Code.

### Install

```bash
npx @cortex.memory/cli init
```

### What's included

- **MCP Server** — 7 tools for Claude Code integration
- **CLI** — 30+ commands for memory management
- **Dashboard** — Next.js web UI at localhost:7434
- **VS Code Extension** — Save memories from your editor
- **Native Mac App** — SwiftUI desktop application
- **Electron App** — Cross-platform desktop wrapper
- **Multi-machine Sync** — Turso-powered, you own the database
- **Quality Gate** — 6-rule engine for memory quality
- **Session Summarizer** — AI reviews what you missed
- **85+ tests** across 15 test files

### Security

- AES-256-GCM encrypted credentials
- Zod validation on all API inputs
- Rate limiting (100/min global)
- SQL injection protection
- Localhost-only binding

### Docs

- [Architecture](docs/ARCHITECTURE.md)
- [CLI Reference](docs/CLI.md)
- [API Reference](docs/API.md)
- [Sync Guide](docs/SYNC.md)
- [Security Model](docs/SECURITY-MODEL.md)
- [FAQ](docs/FAQ.md)

MIT Licensed — The Production Line
NOTES
)" 2>&1
pass "GitHub release v1.0.0 created"

# ── Step 5: Commit SHA update ──
header "STEP 5: COMMIT & PUSH"
if git diff --quiet packages/installer/homebrew/cortex.rb 2>/dev/null; then
  info "No SHA changes to commit"
else
  git add packages/installer/homebrew/cortex.rb
  git commit -m "Update Homebrew SHA256 after npm publish" 2>&1 | tail -1
  git push origin main 2>&1 | tail -1
  pass "SHA256 committed and pushed"
fi

# ── Step 6: Set GitHub repo topics ──
header "STEP 6: REPO OPTIMIZATION"
gh repo edit ProductionLineHQ/cortex \
  --add-topic claude --add-topic claude-code --add-topic mcp \
  --add-topic persistent-memory --add-topic ai-memory \
  --add-topic developer-tools --add-topic typescript \
  --add-topic sqlite --add-topic open-source 2>/dev/null
pass "GitHub topics set"

# ── Done ──
header "LAUNCH COMPLETE"
echo ""
echo "  ╔═══════════════════════════════════════════════════╗"
echo "  ║                                                   ║"
echo "  ║   Cortex v1.0.0 is LIVE                          ║"
echo "  ║                                                   ║"
echo "  ║   npm:    @cortex.memory/cli                      ║"
echo "  ║   repo:   github.com/ProductionLineHQ/cortex      ║"
echo "  ║   install: npx @cortex.memory/cli init            ║"
echo "  ║                                                   ║"
echo "  ╚═══════════════════════════════════════════════════╝"
echo ""
echo "  Next steps:"
echo "  1. Deploy cortex.sh (Vercel: cd packages/web && vercel)"
echo "  2. Publish VS Code extension (cd packages/vscode && vsce publish)"
echo "  3. Send Newsletter Issue #3 (see NEWSLETTER_ISSUE_3.md)"
echo "  4. Post to HN, Reddit, X (see LAUNCH.md)"
echo ""
