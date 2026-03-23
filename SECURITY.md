# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in Cortex, please report it privately. Do not open a public GitHub issue.

**Email:** security@theproductionline.com

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if you have one)

## Response SLA

- **Acknowledgment:** Within 48 hours of your report
- **Initial assessment:** Within 5 business days
- **Critical vulnerabilities:** Patch within 7 days of confirmation
- **High vulnerabilities:** Patch within 14 days
- **Medium/Low:** Addressed in the next scheduled release

## Scope

The following are in scope for security reports:

- **MCP server** (`packages/server`) — the localhost API and MCP tool handlers
- **Daemon process** — the background service that runs on your machine
- **Sync layer** — Turso sync, credential storage, data in transit
- **Quality gate** — sensitive data filtering (API keys, passwords, tokens)
- **CLI** (`packages/cli`) — command injection, privilege escalation
- **Dashboard** (`packages/dashboard`) — XSS, CSRF, authentication bypass
- **Electron app** (`packages/electron`) — remote code execution, sandbox escape

## Out of Scope

- Vulnerabilities in third-party dependencies we do not control (report these upstream; we will update when patches are available)
- Issues that require physical access to the machine where Cortex is running
- Social engineering attacks
- Denial of service against the localhost-only server

## Architecture Security Notes

Cortex is designed with a local-first security model:

- **All data stored locally** in SQLite at `~/.cortex/cortex.db`
- **MCP server binds to localhost only** — no external network access
- **Credentials encrypted** with AES-256-GCM before storage
- **Quality gate blocks sensitive data** — API keys, passwords, tokens, and private keys are rejected before they reach the database
- **Zero telemetry by default** — no analytics, no crash reporting, no phone-home
- **Optional sync uses Turso** — you create the database, you own the credentials, data is encrypted in transit via TLS

## Researcher Recognition

We credit security researchers in the CHANGELOG and release notes for responsibly disclosed vulnerabilities. We will never pursue legal action against researchers acting in good faith.

## PGP Key

For encrypted reports, contact security@theproductionline.com and we will provide a public key.
