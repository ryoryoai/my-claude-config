# my-claude-config

Private Claude Code configuration with custom skills and agents.

## Structure

```
.
├─ bootstrap/           # ClaudeCodeBootstrap (submodule)
└─ .claude/
   ├─ skills/           # Private skills
   ├─ agents/           # Private agents
   └─ settings.json     # Unified settings
```

## Setup

```bash
git clone --recursive git@github.com:ryoryoai/my-claude-config.git
cd my-claude-config
```

## Update Bootstrap

```bash
cd bootstrap
git pull origin main
cd ..
git add bootstrap
git commit -m "chore: update bootstrap"
```

## Adding Private Skills

Place `.md` files in `.claude/skills/` with YAML frontmatter:

```yaml
---
name: my-skill
description: My private skill
path: /my-skill
---

# Instructions

...
```
