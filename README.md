# my-claude-config

Personal Claude Code configuration with custom skills, agents, and automation hooks.

個人用 Claude Code 設定リポジトリ。カスタムスキル、エージェント、自動化フックを含みます。

> **Note**: This repository is **public** for AI visibility and reference, but is intended for personal use. Not designed as a reusable template.
>
> **注意**: このリポジトリはAI参照用に**Public**ですが、個人利用を想定しています。再利用可能なテンプレートとしての設計ではありません。

---

## Setup / セットアップ

```bash
# 1. Clone this repo / リポジトリをクローン
git clone git@github.com:ryoryoai/my-claude-config.git
cd my-claude-config

# 2. Install base configuration / ベース設定をインストール
npx create-ccb --force

# 3. Install UI/UX Pro Max skill (optional) / UI/UX Pro Max スキルをインストール（任意）
npm install -g uipro-cli
uipro init --ai claude
```

---

## Structure / 構成

```
.
└─ .claude/
   ├─ skills/           # Skills / スキル
   ├─ agents/           # Agents / エージェント
   ├─ commands/         # Slash commands / スラッシュコマンド
   │   ├─ core/         # Core commands / コアコマンド
   │   ├─ optional/     # Optional commands / オプションコマンド
   │   ├─ handoff/      # Handoff commands / ハンドオフコマンド
   │   └─ ralph-wiggum/ # Ralph loop commands / Ralph ループコマンド
   ├─ hooks/            # Automation hooks / 自動化フック
   ├─ scripts/          # Hook scripts / フックスクリプト
   └─ settings.json     # Settings / 設定
```

---

## Available Skills / 利用可能なスキル

| Skill | Description |
|-------|-------------|
| `2agent` | PM ↔ Implementation 2-agent workflow / PM↔実装の2エージェントワークフロー |
| `auth` | Authentication & payments (Clerk, Supabase, Stripe) / 認証・決済 |
| `ci` | CI/CD pipeline diagnosis / CI/CD パイプライン診断 |
| `deploy` | Deployment & analytics setup / デプロイ・アナリティクス設定 |
| `docs` | Documentation generation / ドキュメント生成 |
| `impl` | Feature implementation / 機能実装 |
| `maintenance` | Project cleanup / プロジェクト整理 |
| `memory` | SSOT & Plans.md management / SSOT・Plans.md 管理 |
| `plans-management` | Task marker operations / タスクマーカー操作 |
| `principles` | Development guidelines / 開発原則 |
| `review` | Code review (security, performance, quality) / コードレビュー |
| `setup` | Project scaffolding / プロジェクトセットアップ |
| `troubleshoot` | Problem diagnosis / 問題診断 |
| `ui` | UI component generation / UI コンポーネント生成 |
| `ui-ux-pro-max` | Advanced UI/UX design intelligence / 高度な UI/UX デザイン |
| `verify` | Build verification & error recovery / ビルド検証・エラー復旧 |
| `workflow` | Workflow transitions & handoffs / ワークフロー遷移 |

---

## Available Commands / 利用可能なコマンド

### Core Commands / コアコマンド

| Command | Description |
|---------|-------------|
| `/harness-init` | Project setup (env → files → SSOT → verify) / プロジェクトセットアップ |
| `/harness-review` | Code review / コードレビュー |
| `/plan-with-agent` | Create implementation plan / 実装計画作成 |
| `/skill-list` | List available skills / スキル一覧表示 |
| `/sync-status` | Sync progress → Plans.md / 進捗確認・Plans.md 更新 |
| `/validate` | Project validation / プロジェクト検証 |
| `/work` | Execute Plans.md tasks / Plans.md タスク実行 |

### Optional Commands / オプションコマンド

| Command | Description |
|---------|-------------|
| `/cleanup` | Auto-cleanup Plans.md & session-log / 自動整理 |
| `/ci-setup` | Setup GitHub Actions CI/CD / CI/CD 構築 |
| `/crud` | Generate CRUD operations / CRUD 自動生成 |
| `/cursor-mem` | Cursor × Claude-mem integration / Cursor×Claude-mem 統合 |
| `/harness-mem` | Claude-mem setup / Claude-mem セットアップ |
| `/harness-update` | Update harness to latest / ハーネス更新 |
| `/localize-rules` | Localize rules to project / ルールローカライズ |
| `/lsp-setup` | LSP configuration / LSP 設定 |
| `/refactor` | Safe code refactoring / 安全なリファクタリング |
| `/release` | Release automation / リリース自動化 |
| `/remember` | Save learning to Rules/Skills / 学習を記録 |
| `/skills-update` | Manage skill settings / スキル設定管理 |
| `/sync-project-specs` | Sync project specifications / プロジェクト仕様同期 |
| `/sync-ssot-from-memory` | Sync observations to SSOT / 観測をSSOTに同期 |

### Handoff Commands / ハンドオフコマンド

| Command | Description |
|---------|-------------|
| `/handoff-to-cursor` | Generate report for Cursor (PM) / Cursor向け完了報告 |

---

## Ralph Wiggum Loop / Ralph Wiggum ループ

A self-referential loop system that intercepts session exit and feeds prompts back for iterative improvement.

セッション終了を傍受し、同じプロンプトを再入力して反復改善を行う自己参照ループシステム。

### ⚠️ Safety / 安全性

**You must specify at least one stop condition** to prevent infinite loops:

**無限ループを防ぐため、少なくとも1つの停止条件を指定してください：**

- `--max-iterations N` - Required unless using completion-promise
- `--completion-promise 'TEXT'` - Required unless using max-iterations

If neither is specified, the loop defaults to **5 iterations** as a safety measure.

どちらも指定しない場合、安全策として**5回**でループが停止します。

### Usage / 使い方

```bash
# Recommended: Always set a limit / 推奨: 必ず制限を設定
/ralph-loop Build a REST API --max-iterations 20 --completion-promise 'DONE'

# With max iterations only / 最大回数のみ
/ralph-loop Fix the auth bug --max-iterations 10

# With completion promise only (uses default max of 5)
# completion promise のみ（デフォルト最大5回）
/ralph-loop Refactor code --completion-promise 'All tests passing'

# Cancel active loop / ループキャンセル
/cancel-ralph
```

### Options / オプション

| Option | Description | Default |
|--------|-------------|---------|
| `--max-iterations N` | Stop after N iterations / N回で停止 | 5 |
| `--completion-promise 'TEXT'` | Stop when `<promise>TEXT</promise>` is output | none |

### How to Stop / 停止方法

1. **Automatic**: Loop stops at max iterations or when completion promise is output
2. **Manual**: Run `/cancel-ralph` to remove state file
3. **Emergency**: Delete `.claude/ralph-loop.local.md` manually

1. **自動**: 最大回数到達または completion promise 出力時
2. **手動**: `/cancel-ralph` でステートファイルを削除
3. **緊急**: `.claude/ralph-loop.local.md` を手動削除

### How it works / 動作原理

1. `/ralph-loop` creates state file `.claude/ralph-loop.local.md`
2. Stop hook intercepts exit and checks completion
3. If not complete, feeds same prompt back to Claude
4. Loop continues until max iterations or promise detected

1. `/ralph-loop` が状態ファイル `.claude/ralph-loop.local.md` を作成
2. Stop フックが終了を傍受し、完了をチェック
3. 未完了なら同じプロンプトを Claude に再入力
4. 最大回数到達または promise 検出までループ継続

---

## Claude Agent SDK

Build autonomous AI agents with Claude. / Claude で自律的 AI エージェントを構築。

### Setup / セットアップ

```bash
npm install
```

### Usage / 使い方

```bash
# Run example agent / サンプルエージェント実行
npm run agent

# Run with custom prompt / カスタムプロンプトで実行
npx tsx agents/example-agent.ts "Find all TODO comments"

# Run code reviewer / コードレビュー実行
npm run agent:review
npx tsx agents/code-reviewer.ts ./src
```

### Create Custom Agent / カスタムエージェント作成

```typescript
// agents/my-agent.ts
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Your task here",
  options: {
    allowedTools: ["Read", "Edit", "Bash", "Glob", "Grep"],
  },
})) {
  // Handle messages
}
```

### Available Tools / 利用可能なツール

| Tool | Description |
|------|-------------|
| `Read` | Read files / ファイル読み込み |
| `Write` | Create files / ファイル作成 |
| `Edit` | Modify files / ファイル編集 |
| `Bash` | Run commands / コマンド実行 |
| `Glob` | Find files by pattern / パターンでファイル検索 |
| `Grep` | Search contents / 内容検索 |
| `WebSearch` | Search the web / Web検索 |
| `WebFetch` | Fetch web pages / Webページ取得 |

---

## Adding Private Skills / プライベートスキル追加

Place skill directories in `.claude/skills/` with a `SKILL.md` file:

`.claude/skills/` にスキルディレクトリを配置し、`SKILL.md` ファイルを作成：

```markdown
---
name: my-skill
description: My private skill
---

# Instructions

Your skill instructions here...
```

---

## Update / 更新

```bash
# Update bootstrap (always latest via npx)
# ブートストラップ更新（npx で常に最新）
npx create-ccb --force

# Update UI/UX Pro Max
# UI/UX Pro Max 更新
uipro update
uipro init --ai claude

# Update harness (from within Claude Code)
# ハーネス更新（Claude Code 内から）
/harness-update
```

---

## Prerequisites / 前提条件

The following tools are required for full functionality:

以下のツールが完全な機能に必要です：

| Tool | Required For | Install |
|------|--------------|---------|
| `jq` | Ralph loop, hooks | `brew install jq` |
| `perl` | Ralph loop completion detection | Pre-installed on macOS |
| `node` / `npm` | MCP servers, Agent SDK | [nodejs.org](https://nodejs.org) |

---

## Security / セキュリティ

**IMPORTANT**: This repository contains configuration templates only. Secrets must be managed locally.

**重要**: このリポジトリには設定テンプレートのみ含まれます。シークレットはローカルで管理してください。

### Never Commit / コミットしてはいけないもの

- `.env`, `.env.*` - Environment variables / 環境変数
- `.claude/mcp.json` - MCP config with tokens / トークンを含むMCP設定
- `.cursor/mcp.json` - Cursor MCP config
- `*.key`, `credentials.json` - API keys and credentials / APIキー・認証情報

### MCP Configuration / MCP設定

```bash
# Copy the example and edit with your values
# exampleをコピーして自分の値で編集
cp .claude/mcp.json.example .claude/mcp.json

# Edit the file - replace ${SUPABASE_ACCESS_TOKEN} etc. with actual values
# ファイルを編集 - ${SUPABASE_ACCESS_TOKEN} 等を実際の値に置換
```

### Filesystem MCP Safety / Filesystem MCP の安全性

If adding a filesystem MCP server, follow the principle of least privilege:

Filesystem MCPサーバーを追加する場合は最小権限の原則に従ってください：

```json
{
  "filesystem": {
    "command": "npx",
    "args": [
      "-y", "@anthropic-ai/mcp-server-filesystem",
      "/path/to/your/project"  // Only allow specific directories
    ]
  }
}
```

**DO NOT** use:
- `--dangerously-skip-permissions` flag
- Home directory (`~` or `/Users/xxx`)
- Root (`/`)

---

## Advanced: Parallel Claude Workflow / 並列Claude活用

For maximum efficiency, run multiple Claude instances in parallel.

最大効率のために、複数のClaudeインスタンスを並列実行。

### Setup / セットアップ

```bash
# Terminal 1-5: CLI instances for different tasks
# ターミナル1-5: 異なるタスク用のCLIインスタンス
claude  # Each in a different tmux pane or terminal tab

# Web instances: claude.ai/code with teleport
# Webインスタンス: claude.ai/code でテレポート使用
```

### Recommended Workflow / 推奨ワークフロー

| Instance | Task Type | Example |
|----------|-----------|---------|
| Terminal 1 | Main development | Feature implementation |
| Terminal 2 | Testing | Run tests, fix failures |
| Terminal 3 | Code review | Review changes in parallel |
| Terminal 4 | Documentation | Update docs, comments |
| Terminal 5 | DevOps | CI/CD, deployment |
| Web 1-5 | Research | API docs, troubleshooting |

### Tips / ヒント

1. **Use Plan mode first** - Always start complex tasks with `/plan-with-agent`
2. **Leverage subagents** - Use specialized agents for specific tasks
3. **PostToolUse hooks** - Auto-format files after edits
4. **System notifications** - Get alerts when long tasks complete
5. **Ralph loop** - For iterative improvement tasks

### Notification Setup (macOS) / 通知設定 (macOS)

```bash
# Add to your shell profile
# シェルプロファイルに追加
claude_notify() {
  claude "$@" && osascript -e 'display notification "Task complete" with title "Claude Code"'
}
```

---

## License / ライセンス

Personal configuration repository. Public for AI reference purposes.

個人設定リポジトリ。AI参照用にPublic公開。
