# Security Policy

This repository is **public** for AI visibility and reference purposes. It contains Claude Code configuration templates, not secrets.

## What is NOT included (and must never be committed)

| File | Contains |
|------|----------|
| `.env`, `.env.*` | API keys, tokens, passwords |
| `.claude/mcp.json` | MCP server configurations with tokens |
| `.cursor/mcp.json` | Cursor MCP configurations |
| `credentials.json`, `*.key`, `*.pem` | Service account keys |

## Safe to commit

- `.claude/mcp.json.example` - Template with placeholders
- `.claude/settings.json` - Non-sensitive settings
- `.claude/skills/`, `.claude/commands/` - Skill and command definitions
- `.claude/hooks/` - Hook scripts (no embedded secrets)

## MCP Server Security

When configuring MCP servers:

### Filesystem MCP

```json
// SAFE - Specific project directory only
"args": ["-y", "@anthropic-ai/mcp-server-filesystem", "/path/to/project"]

// DANGEROUS - Never do these:
"args": ["--dangerously-skip-permissions", ...]  // Bypasses safety
"args": [..., "/"]                                // Root access
"args": [..., "/Users/xxx"]                       // Home directory
```

### API Tokens

Always use environment variables, not hardcoded values:

```json
// SAFE
"env": { "TOKEN": "${MY_TOKEN}" }

// DANGEROUS
"env": { "TOKEN": "sk-actual-secret-key" }
```

## Ralph Loop Safety

The Ralph loop system now defaults to **5 iterations** to prevent infinite loops. To run with more iterations, explicitly set `--max-iterations N`.

The `.claude/ralph-loop.local.md` state file is gitignored and should never be committed.

## Reporting Issues

If you discover a security issue in this configuration:

1. Do not open a public issue
2. Contact the repository owner directly
3. Allow time for the issue to be addressed before disclosure

## Local Setup

```bash
# 1. Copy example configs
cp .claude/mcp.json.example .claude/mcp.json

# 2. Edit with your actual tokens
# Replace ${PLACEHOLDER} with real values

# 3. Verify it's gitignored
git status  # Should NOT show .claude/mcp.json
```
