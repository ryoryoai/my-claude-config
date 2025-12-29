# my-claude-config

Private Claude Code configuration with custom skills and agents.

## Setup

```bash
# 1. Clone this repo
git clone git@github.com:ryoryoai/my-claude-config.git
cd my-claude-config

# 2. Install base configuration
npm install -g claude-bootstrap-cli
claude-bootstrap init --force

# 3. Install additional skills (optional)
npm install -g uipro-cli
uipro init --ai claude
```

## Structure

```
.
└─ .claude/
   ├─ skills/           # Skills (from CLI + private)
   ├─ agents/           # Agents (from CLI + private)
   ├─ commands/         # Commands (from CLI)
   ├─ hooks/            # Hooks (from CLI)
   └─ settings.json     # Settings
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

## Update

```bash
# Update bootstrap
claude-bootstrap update
claude-bootstrap init --force

# Update UI/UX Pro Max
uipro update
uipro init --ai claude
```
