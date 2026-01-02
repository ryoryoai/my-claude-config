# my-claude-config

Private Claude Code configuration with custom skills, agents, and automation hooks.

個人用 Claude Code 設定リポジトリ。カスタムスキル、エージェント、自動化フックを含みます。

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

### Usage / 使い方

```bash
# Start a loop / ループ開始
/ralph-loop Build a REST API --max-iterations 20 --completion-promise 'DONE'

# Cancel active loop / ループキャンセル
/cancel-ralph
```

### Options / オプション

| Option | Description |
|--------|-------------|
| `--max-iterations N` | Stop after N iterations / N回で停止 |
| `--completion-promise 'TEXT'` | Stop when `<promise>TEXT</promise>` is output / 出力時に停止 |

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
import { query } from "@anthropic-ai/claude-code";

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

## License

Private repository. Not for redistribution.

プライベートリポジトリ。再配布不可。
