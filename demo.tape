# Cortex Demo — Terminal Recording
# Run: vhs demo.tape

Output assets/cortex-demo.gif

Set Shell "bash"
Set FontSize 16
Set Width 900
Set Height 500
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set PlaybackSpeed 0.5

# Scene 1: Install
Type "npx @cortex.memory/cli init"
Sleep 500ms
Enter
Sleep 1.5s

# Simulated output
Type@0ms ""
Sleep 100ms

Set TypingSpeed 0ms
Type "  ✓ Cortex v1.0.0 installed"
Enter
Type "  ✓ Daemon started (PID 48291)"
Enter
Type "  ✓ MCP server registered with Claude Code"
Enter
Type "  ✓ Database created (~/.cortex/cortex.db)"
Enter
Enter
Type "  Cortex is ready. Open Claude Code — it will remember."
Enter
Enter
Set TypingSpeed 40ms

Sleep 2s

# Scene 2: After a few sessions — show what Cortex captured
Type "cortex status"
Sleep 300ms
Enter
Sleep 1s

Set TypingSpeed 0ms
Enter
Type "  Daemon:     running (PID 48291, uptime 3d 14h)"
Enter
Type "  MCP Server: localhost:7434 (5 tools)"
Enter
Type "  Dashboard:  localhost:7433"
Enter
Type "  Database:   ~/.cortex/cortex.db (2.1 MB)"
Enter
Enter
Type "  Projects:"
Enter
Type "    my-saas-app       89 memories (active)"
Enter
Type "    cortex            34 memories"
Enter
Type "    infra-scripts     12 memories"
Enter
Type "    Total:           135 memories across 3 projects"
Enter
Enter
Set TypingSpeed 40ms

Sleep 2s

# Scene 3: Show memories
Type "cortex show my-saas-app --type decision --limit 4"
Sleep 300ms
Enter
Sleep 1s

Set TypingSpeed 0ms
Enter
Type "  # Decision memories for my-saas-app (showing 4 of 23)"
Enter
Enter
Type "  [1] importance:9  2025-03-18  #database #orm"
Enter
Type "      Using Drizzle ORM — better edge runtime support, no binary dep"
Enter
Enter
Type "  [2] importance:8  2025-03-17  #react #architecture"
Enter
Type "      Server components by default, use client only for state/effects"
Enter
Enter
Type "  [3] importance:8  2025-03-16  #auth"
Enter
Type "      Clerk for auth, Supabase for DB only — no Supabase auth/storage"
Enter
Enter
Type "  [4] importance:7  2025-03-15  #styling"
Enter
Type "      Tailwind 4 + CVA for component variants, no CSS modules"
Enter
Enter
Set TypingSpeed 40ms

Sleep 2s

# Scene 4: Search across projects
Type 'cortex search "websocket timeout"'
Sleep 300ms
Enter
Sleep 1s

Set TypingSpeed 0ms
Enter
Type "  Found 2 matches across 1 project:"
Enter
Enter
Type "  [my-saas-app] thread (importance:7)"
Enter
Type "    WebSocket drops after 100s — suspect Cloudflare proxy timeout"
Enter
Enter
Type "  [my-saas-app] error (importance:6)"
Enter
Type "    Reconnection loop when server restarts during active WS session"
Enter
Enter
Set TypingSpeed 40ms

Sleep 2s

# Scene 5: The payoff — what Claude sees
Type "# Next time Claude Code opens, it already knows all of this."
Sleep 500ms
Enter
Type "# No re-explaining. No context files. It just remembers."
Sleep 1s
Enter
Enter

Sleep 3s
