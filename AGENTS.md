# AGENTS.md - Available Subagents

このリポジトリで利用可能なサブエージェント一覧です。
Task ツールで `subagent_type` を指定して呼び出します。

## 使い方

```
Task tool を使用:
- prompt: "タスクの説明"
- subagent_type: "agent-name"
```

---

## カテゴリ別一覧

### 開発言語特化

| Agent | Description | 主な用途 |
|-------|-------------|---------|
| `typescript-pro` | TypeScript 5.0+ の高度な型システム、フルスタック型安全性、ビルド最適化 | TypeScript/Node.js 開発 |
| `python-pro` | Python 3.11+ のエコシステム全般（Web、データサイエンス、自動化） | Python 開発 |
| `nextjs-developer` | Next.js 14+ App Router、Server Components、Server Actions | Next.js フルスタック |

### コード品質

| Agent | Description | 主な用途 |
|-------|-------------|---------|
| `code-reviewer` | セキュリティ/性能/品質を多角的にレビュー | コードレビュー |
| `code-simplifier` | コードの複雑性を削減し、可読性を向上 | リファクタリング |
| `refactoring-specialist` | 安全なコード変換、デザインパターン適用、レガシーコード改善 | 大規模リファクタ |

### DevOps/インフラ

| Agent | Description | 主な用途 |
|-------|-------------|---------|
| `ci-cd-fixer` | CI失敗時の診断・修正を安全第一で支援 | CI/CD トラブルシュート |
| `terraform-engineer` | Infrastructure as Code、マルチクラウド、モジュール設計 | Terraform/IaC |
| `kubernetes-specialist` | プロダクション級クラスタ管理、コンテナオーケストレーション | Kubernetes 運用 |

### AI/LLM

| Agent | Description | 主な用途 |
|-------|-------------|---------|
| `llm-architect` | LLMアーキテクチャ設計、RAG実装、モデル最適化、本番デプロイ | LLM アプリ設計 |
| `prompt-engineer` | プロンプト設計、最適化、評価、本番運用 | プロンプト最適化 |
| `mcp-developer` | Model Context Protocol のサーバー/クライアント開発 | MCP 開発 |

### プロジェクト管理

| Agent | Description | 主な用途 |
|-------|-------------|---------|
| `project-analyzer` | 新規/既存プロジェクト判定と技術スタック検出 | プロジェクト分析 |
| `project-scaffolder` | 指定スタックで動くプロジェクトを自動生成 | プロジェクト作成 |
| `project-state-updater` | Plans.md とセッション状態の同期・ハンドオフ支援 | 状態管理 |

### エラー処理/検証

| Agent | Description | 主な用途 |
|-------|-------------|---------|
| `error-recovery` | エラー復旧（原因切り分け→安全な修正→再検証） | エラー修復 |
| `verify-app` | ブラウザ自動化でE2E検証を実行 | E2E テスト |

### 並列処理

| Agent | Description | 主な用途 |
|-------|-------------|---------|
| `multi-agent-coordinator` | マルチエージェントワークフロー、タスク分散、並列実行 | 並列タスク管理 |

---

## 使用例

### TypeScript 開発

```
Task:
  prompt: "UserService クラスに認証メソッドを追加して"
  subagent_type: "typescript-pro"
```

### コードレビュー

```
Task:
  prompt: "src/auth/ 配下のセキュリティレビューをして"
  subagent_type: "code-reviewer"
```

### E2E 検証

```
Task:
  prompt: "ログインフローの E2E テストを実行して"
  subagent_type: "verify-app"
```

### CI 修復

```
Task:
  prompt: "GitHub Actions の失敗を診断して修正して"
  subagent_type: "ci-cd-fixer"
```

### コード簡素化

```
Task:
  prompt: "src/utils/parser.ts の複雑性を削減して"
  subagent_type: "code-simplifier"
```

---

## Agent 詳細

各エージェントの詳細は `.claude/agents/` 配下の個別ファイルを参照：

```
.claude/agents/
├── ci-cd-fixer.md
├── code-reviewer.md
├── code-simplifier.md
├── error-recovery.md
├── kubernetes-specialist.md
├── llm-architect.md
├── mcp-developer.md
├── multi-agent-coordinator.md
├── nextjs-developer.md
├── project-analyzer.md
├── project-scaffolder.md
├── project-state-updater.md
├── prompt-engineer.md
├── python-pro.md
├── refactoring-specialist.md
├── terraform-engineer.md
├── typescript-pro.md
└── verify-app.md
```

---

## カスタムエージェントの追加

`.claude/agents/` に新しい `.md` ファイルを追加：

```markdown
---
name: my-agent
description: エージェントの説明
tools: [Read, Edit, Bash, Glob, Grep]
model: sonnet
color: blue
---

# My Agent

エージェントの詳細説明...
```

### 必須フィールド

| フィールド | 説明 |
|-----------|------|
| `name` | エージェント名（subagent_type で指定） |
| `description` | 短い説明（一覧表示用） |
| `tools` | 使用可能なツールのリスト |

### オプションフィールド

| フィールド | 説明 | デフォルト |
|-----------|------|-----------|
| `model` | 使用するモデル | sonnet |
| `color` | ステータス表示の色 | - |
