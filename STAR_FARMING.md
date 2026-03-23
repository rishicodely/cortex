# Star Farming Infrastructure

> Copy-paste these exact strings into the codebase and content.

## 1. cortex doctor — Star Prompt

Add this to the end of the `cortex doctor` output when all checks pass:

```
All checks passed. Cortex is healthy.

If it's been useful, a star helps other engineers find it:
https://github.com/ProductionLineHQ/cortex
```

## 2. README Star Banner

Add this one line right above the first `## The Problem` heading in README.md:

```
If Cortex is useful to you, a star helps other engineers find it.
```

Already added in the current README.

## 3. Post-Install Message

Print this after `brew install cortex-memory` or `npx @cortex.memory/cli init` completes:

```

  Cortex installed successfully.

  Next steps:
    cd your-project
    cortex init          Initialize Cortex for this project
    cortex doctor        Check that everything is working

  Need help?
    cortex help          Show all commands
    GitHub Issues        https://github.com/ProductionLineHQ/cortex/issues

  If Cortex saves you time, a GitHub star helps others find it:
  https://github.com/ProductionLineHQ/cortex

```

## 4. Newsletter CTA for Stars (Issue #3)

Add this paragraph to the Cortex section of The Production Line Issue #3:

```
One more thing — if you try Cortex and it saves you even one re-explanation session, I'd appreciate a star on the repo. It's how open-source projects get discovered, and right now we're competing for visibility against tools backed by large companies. A star takes two seconds and directly affects whether other engineers find this tool when they search for Claude Code memory solutions. Here's the link: github.com/ProductionLineHQ/cortex
```
