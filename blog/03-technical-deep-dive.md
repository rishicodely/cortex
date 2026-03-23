<!-- meta:title How Cortex Captures Claude Code Memory: A Technical Walkthrough of MCP Tool Interception -->
<!-- meta:description Technical deep dive into how Cortex uses the Model Context Protocol to give Claude Code persistent memory. MCP tool design, quality gate implementation, and summarizer architecture. -->
<!-- meta:keywords MCP tool interception, Claude Code MCP server, how MCP tools work, building MCP servers, Model Context Protocol tutorial -->
<!-- meta:canonical https://www.theproductionline.ai/blog/technical-deep-dive -->

# How Cortex Captures Claude Code Memory: A Technical Walkthrough of MCP Tool Interception

If you are building MCP servers or working in the Claude Code ecosystem, this post walks through the specific technical decisions behind Cortex — a persistent memory layer for Claude Code. This is not a product pitch. This is architecture.

## What MCP is (one paragraph)

The Model Context Protocol is a standardized interface between Claude Code and external tools. When you install an MCP server, Claude Code discovers it at session start and can call its tools during conversation. An MCP server is a process that speaks JSON-RPC over stdio or SSE, registers a set of tools with typed parameters, and handles tool calls from Claude. The @modelcontextprotocol/sdk handles the protocol negotiation — you define the tools and their handlers.

## The core insight

Claude Code does not expose conversation transcripts. You cannot subscribe to a stream of messages or hook into the conversation lifecycle. What Claude Code does expose is tool calls. When Claude decides to save a memory, it makes an explicit MCP tool call with structured parameters. When Claude needs context, it makes a tool call to read memories.

This constraint is actually a feature. Instead of trying to passively observe and extract context from raw conversation (which would be noisy, privacy-invasive, and technically fragile), Cortex lets Claude decide what is worth remembering. Claude is remarkably good at identifying decisions, preferences, and important context when given the right tools and prompts. The tool interface makes memory capture intentional rather than accidental.

## Tool design

Cortex exposes five MCP tools. Here is the actual tool registration:

```typescript
server.tool(
  "cortex_save_memory",
  "Save a memory to the Cortex database",
  {
    project: z.string().describe("Project identifier"),
    type: z.enum(["decision", "context", "preference", "thread", "error", "learning"]),
    content: z.string().min(50).max(2000).describe("The memory content"),
    reason: z.string().min(10).describe("Why this memory is worth saving"),
    importance: z.number().int().min(1).max(10).describe("Importance score"),
    tags: z.array(z.string()).optional().describe("Categorization tags"),
    expires_at: z.string().datetime().optional().describe("Expiration for threads/errors"),
  },
  async (params) => {
    const validation = qualityGate.validate(params);
    if (!validation.passed) {
      return { error: validation.reason, rule: validation.failedRule };
    }
    const memory = await db.saveMemory(params);
    return { saved: true, id: memory.id };
  }
);
```

The key design decisions:

1. **Zod schemas on every parameter.** MCP tool parameters are validated at the protocol level, but Zod gives us richer validation (min/max lengths, enum constraints) and better error messages. Claude sees the schema descriptions and uses them to format its tool calls correctly.

2. **The `reason` field is mandatory.** This forces Claude to articulate why a memory matters. Without it, Claude saves observations like "the project uses React" — true but not useful. With a required reason, saves become "Using server components by default — reduces bundle size and avoids hydration mismatches for content pages" — specific and actionable.

3. **Importance is a number, not a category.** Early versions used "low/medium/high" which Claude struggled to calibrate. A 1-10 integer gives more granularity and lets us set a threshold for context injection (default: only inject memories with importance >= 3).

## The quality gate

Every `cortex_save_memory` call passes through the quality gate before reaching SQLite. Here are the seven rules as implemented:

```typescript
const qualityRules: QualityRule[] = [
  {
    name: "content_length",
    validate: (m) => m.content.length >= 50 && m.content.length <= 2000,
    reason: "Content must be 50-2000 characters",
  },
  {
    name: "reason_required",
    validate: (m) => m.reason.length >= 10,
    reason: "Reason must be at least 10 characters",
  },
  {
    name: "duplicate_check",
    validate: async (m) => {
      const existing = await db.getProjectMemories(m.project);
      const maxSimilarity = existing.reduce((max, e) => {
        const sim = tfidfCosineSimilarity(m.content, e.content);
        return Math.max(max, sim);
      }, 0);
      return maxSimilarity < 0.85;
    },
    reason: "Too similar to an existing memory (>85% match)",
  },
  {
    name: "banned_phrases",
    validate: (m) => {
      const banned = [
        /^I will now/i, /^I am going to/i, /^Let me/i,
        /^I'll proceed/i, /^I should note/i,
      ];
      return !banned.some((p) => p.test(m.content));
    },
    reason: "Content starts with a banned phrase (meta-commentary)",
  },
  {
    name: "sensitive_data",
    validate: (m) => {
      const patterns = [
        /[A-Za-z0-9+/]{40,}={0,2}/, // base64 tokens
        /sk-[a-zA-Z0-9]{20,}/,       // OpenAI/Stripe keys
        /AKIA[0-9A-Z]{16}/,          // AWS access keys
        /ghp_[a-zA-Z0-9]{36}/,       // GitHub tokens
        /-----BEGIN.*PRIVATE KEY-----/,
        /password\s*[:=]\s*\S+/i,
      ];
      return !patterns.some((p) => p.test(m.content));
    },
    reason: "Content appears to contain sensitive data",
  },
  {
    name: "quality_score",
    validate: (m) => {
      let score = 0;
      if (/[A-Z][a-z]+(?:[A-Z][a-z]+)+/.test(m.content)) score += 2; // camelCase terms
      if (/`[^`]+`/.test(m.content)) score += 1;  // code references
      if (m.content.split(" ").length > 10) score += 1; // sufficient detail
      if (/because|since|due to|in order to/i.test(m.content)) score += 2; // reasoning
      if (m.tags && m.tags.length > 0) score += 1; // categorized
      return score >= 3;
    },
    reason: "Content quality score too low (needs more specificity)",
  },
  {
    name: "rate_limit",
    validate: async (m) => {
      const sessionCount = await db.getSessionSaveCount(m.project);
      const dayCount = await db.getDaySaveCount(m.project);
      return sessionCount < 50 && dayCount < 200;
    },
    reason: "Rate limit exceeded (50/session or 200/day)",
  },
];
```

The TF-IDF duplicate detection deserves extra explanation. We build a term frequency vector for each memory, weight terms by inverse document frequency across the project's memory corpus, and compute cosine similarity between the new memory and every existing memory. At 500 memories, this takes under 10 milliseconds. At 5000 memories (a large project after months of use), it takes roughly 50 milliseconds — still within acceptable latency for an async save operation.

The 0.85 threshold was calibrated empirically. At 0.90, too many near-duplicates slip through. At 0.80, legitimate memories that discuss the same topic (but make different points) get rejected. 0.85 catches "we chose Drizzle over Prisma for edge support" vs "selected Drizzle instead of Prisma because of edge runtime compatibility" while allowing "Drizzle migration command needs explicit schema path" through.

## The summarizer

The summarizer runs after every Claude Code session ends. It solves a specific problem: Claude often discusses important context during a session but forgets to explicitly save it as a memory.

Architecture:

1. The daemon maintains an audit log of all tool calls during a session
2. When the session ends (detected by MCP connection close), the summarizer activates
3. It sends the audit log to Claude with a prompt: "Review this session's tool calls and identify important decisions, preferences, or context that was discussed but not saved as a memory"
4. Claude generates candidate memories
5. Each candidate passes through the same quality gate
6. Survivors are saved with `source: "summarizer"` so you can distinguish them from explicit saves

The summarizer catches roughly 20-30 percent of the useful context from a session. It is particularly good at identifying implicit preferences — things you demonstrated through code choices but never explicitly stated.

## Performance

- **Session startup latency:** 50-100ms for context injection (SQLite read + JSON formatting)
- **Memory save latency:** <10ms for the quality gate, write is async
- **Summarizer:** runs after session end, does not block anything
- **Database size:** roughly 1 KB per memory, so 1000 memories = 1 MB
- **Daemon memory usage:** ~30 MB idle
- **CPU usage:** negligible when not processing tool calls

## Building your own MCP server

If this architecture interests you, the Cortex source code is a practical reference for building MCP servers with TypeScript. The key files:

- `packages/server/src/mcp.ts` — tool registration and handlers
- `packages/server/src/quality-gate.ts` — validation rules
- `packages/server/src/summarizer.ts` — session summarizer
- `packages/shared/src/schemas.ts` — Zod schemas shared between packages

GitHub: https://github.com/ProductionLineHQ/cortex

The MCP ecosystem is early. If you are building tools for Claude Code, I am interested in what problems you are solving. Open an issue or start a discussion on the repo.
