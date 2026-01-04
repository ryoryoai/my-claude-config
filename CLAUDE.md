# CLAUDE.md - Project Configuration

Personal Claude Code configuration repository with custom skills, agents, and automation hooks.

## Core Rules

1. **Never commit secrets** - `.env`, `mcp.json`, credentials are gitignored
2. **Use absolute paths** - Always use `${CLAUDE_PROJECT_ROOT}` in settings.json
3. **Run /verify after changes** - Ensure build and tests pass
4. **Safety first** - Ralph loop defaults to 5 iterations

## Quick Commands

| Command | Purpose |
|---------|---------|
| `/sync-status` | Check current state and Plans.md |
| `/work` | Execute next task from Plans.md |
| `/harness-review` | Code review (security, quality, performance) |
| `/commit-push-pr` | Commit, push, and create PR |
| `/skill-list` | Show available skills |

## Development Workflow

```
1. /sync-status     - Check what needs to be done
2. /plan-with-agent - Plan implementation (if complex)
3. /work            - Implement the task
4. /harness-review  - Review changes
5. /commit-push-pr  - Commit and create PR
```

## File Structure

```
.claude/
├── commands/           # Slash commands
│   ├── core/          # Essential commands
│   ├── optional/      # Extended functionality
│   ├── handoff/       # PM ↔ Implementation handoffs
│   └── ralph-wiggum/  # Ralph loop commands
├── skills/            # Skill definitions (SKILL.md)
├── agents/            # Subagent definitions
├── hooks/             # Automation hooks
│   ├── ralph-wiggum/  # Ralph loop stop hook
│   └── post-tool-use/ # Auto-format after edits
├── scripts/           # Hook implementation scripts
└── settings.json      # Claude Code settings
```

## Key Subagents

| Agent | When to Use |
|-------|-------------|
| `typescript-pro` | TypeScript/Node.js development |
| `python-pro` | Python development |
| `nextjs-developer` | Next.js App Router projects |
| `code-reviewer` | Multi-angle code review |
| `code-simplifier` | Reduce code complexity |
| `verify-app` | E2E browser verification |
| `error-recovery` | Diagnose and fix errors |

## Skills Overview

- **impl** - Feature implementation
- **review** - Code review (security, performance, quality, accessibility)
- **verify** - Build verification and error recovery
- **setup** - Project scaffolding
- **ci** - CI/CD pipeline diagnosis
- **deploy** - Deployment and analytics
- **auth** - Authentication (Clerk, Supabase) and payments (Stripe)
- **ui** / **ui-ux-pro-max** - UI component generation

## Ralph Wiggum Loop

Self-referential loop for iterative improvement:

```bash
# Start loop with safety limits
/ralph-loop Build a REST API --max-iterations 20 --completion-promise 'DONE'

# Cancel active loop
/cancel-ralph
```

Default: 5 iterations max (safety measure against infinite loops)

## MCP Servers

Configured in `.claude/mcp.json` (gitignored):
- **supabase** - Database and auth
- **context7** - Documentation lookup
- **playwright** - Browser automation
- **serena** - Semantic code analysis

## Security

See [SECURITY.md](SECURITY.md) for:
- What files to never commit
- MCP server configuration safety
- Filesystem access restrictions
