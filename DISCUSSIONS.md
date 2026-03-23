# GitHub Discussions — Setup & Seed Posts

> Create these categories and posts on launch day.

## Categories to Create

| # | Name | Emoji | Type | Description |
|---|------|-------|------|-------------|
| 1 | Announcements | :mega: | Announcement | Release notes, roadmap updates, and project news |
| 2 | Q&A | :question: | Q&A | Ask questions and get answers from the community |
| 3 | Ideas | :bulb: | General | Feature ideas and suggestions not ready for a formal issue |
| 4 | Show and Tell | :rocket: | General | Share what you've built with Cortex or show your memory stats |
| 5 | General | :speech_balloon: | General | Everything else — workflow tips, integrations, discussion |

## Seed Post 1 — Welcome (pin to Announcements)

**Title:** Welcome to Cortex Discussions

**Body:**

Hey — Koundinya here, the maintainer of Cortex.

This is the place to ask questions, share ideas, show what you've built, and discuss anything related to Cortex and Claude Code memory.

A few guidelines:
- **Q&A** is for support questions. I'll mark accepted answers so future users can find solutions quickly.
- **Ideas** is for feature suggestions that need discussion before becoming a formal issue. If the idea is well-defined and ready to implement, open an issue directly instead.
- **Show and Tell** is for sharing your setup — run `cortex show` or `cortex stats` and tell us what Cortex is capturing for your projects. I find these incredibly useful for improving the quality gate.
- **Announcements** is where I'll post release notes and roadmap updates.

For bug reports and feature requests with clear specs, use [GitHub Issues](https://github.com/ProductionLineHQ/cortex/issues) with the bug or feature template.

Looking forward to building this with you.

## Seed Post 2 — General

**Title:** What's your biggest Claude Code workflow frustration?

**Body:**

I built Cortex to solve one specific frustration: re-explaining my project to Claude Code every morning. But I know there are other pain points.

What frustrates you most about using Claude Code daily? What context do you find yourself repeating? What do you wish Claude Code remembered?

I'm asking because the answer shapes what memory types Cortex should capture. Right now we have six types (Decision, Context, Preference, Thread, Error, Learning) — but there might be categories I'm missing entirely.

## Seed Post 3 — Show and Tell

**Title:** Share your cortex show output — what is Cortex saving for your projects?

**Body:**

I'm curious what Cortex captures for different types of projects. If you've been using it for a few sessions, run `cortex stats` and share what you see.

Here's mine for the Cortex project itself (yes, I use Cortex to build Cortex):

```
cortex — 34 memories

By type:
  Decision:    12 (35%)
  Context:      8 (24%)
  Preference:   6 (18%)
  Thread:       4 (12%)
  Error:        2 (6%)
  Learning:     2 (6%)
```

The decisions are mostly architecture choices (better-sqlite3 over Drizzle, Fastify over Express, MCP tool design). The threads are open investigations I haven't resolved yet.

What does yours look like?

## Seed Post 4 — Ideas

**Title:** Roadmap discussion: what should we build next?

**Body:**

Here's what's currently planned:

- Multi-machine sync via Turso (in progress)
- VS Code extension with memory sidebar (in beta)
- Team sharing — shared memory spaces for engineering teams
- Memory analytics — usage patterns, most-referenced memories

What would move the needle for you? What's missing that would make Cortex significantly more useful in your workflow?

I'll use upvotes on replies to help prioritize. Everything here is on the table.

## Seed Post 5 — Q&A

**Title:** Does Cortex work with monorepos?

**Body:**

I have a pnpm monorepo with 6 packages. When I run `cortex init` at the root, it creates one project for the entire repo. But I'd like separate memory spaces for each package — decisions about the API server shouldn't pollute the frontend app's context.

Is there a way to do this?

**Answer (post immediately):**

Yes. Run `cortex init --name <package-name>` inside each package directory:

```bash
cd packages/api
cortex init --name my-app-api

cd packages/web
cortex init --name my-app-web
```

Cortex uses the working directory for project detection. When you open Claude Code from `packages/api`, it loads the `my-app-api` memories. From `packages/web`, it loads `my-app-web`.

If you want shared memories across all packages (like overall architecture decisions), create a third project at the monorepo root:

```bash
cd /path/to/monorepo
cortex init --name my-app-shared
```

Then pin the important shared memories with `cortex pin <id>` so they appear in every context injection regardless of which subdirectory you're in. (Pinned memories are global by default.)
