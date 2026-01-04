# エージェント選択テスト結果

**実行日時**: 2026-01-04
**テストスイート**: agent-selection

---

## サマリー

| カテゴリ | Pass | Fail | Skip | 合計 |
|---------|------|------|------|------|
| A: single-select | 7 | 0 | 0 | 7 |
| B: ambiguous | 4 | 0 | 0 | 4 |
| C: multi-agent | 4 | 0 | 0 | 4 |
| D: edge-case | 2 | 2 | 0 | 4 |
| **合計** | **17** | **2** | **0** | **19** |

**正解率: 89.5% (17/19)**

---

## 成功基準

| レベル | 基準 | 達成 |
|-------|------|-----|
| 必須 | A（単一選択）で80%以上正解 | ✅ 100% (7/7) |
| 推奨 | B（曖昧要件）で適切な質問または妥当な選択 | ✅ 100% (4/4) |
| 理想 | C（複数連携）で正しい順序・組み合わせ | ✅ 100% (4/4) |

---

## 分析

### 良好な点
- A～C カテゴリで100%の正解率
- 複数エージェントが必要なケースでも正しく選択
- 曖昧な要件でも妥当なエージェントを提案

### 改善点
- **D1 (Rust)**: 専用エージェントがないケースで質問せずエージェントを列挙（ただし「general-purposeを使え」と正しく誘導）
- **D2 (曖昧すぎる)**: 「質問が必須」と認識しつつもエージェントを選択してしまった

---

## 使い方

```bash
# 全テスト実行
./run-tests.sh

# カテゴリ指定
./run-tests.sh single-select
./run-tests.sh ambiguous
./run-tests.sh multi-agent
./run-tests.sh edge-case

# 単一テスト実行
./run-tests.sh all A1
./run-tests.sh all B2
```

---

## 詳細結果

(テスト実行後に自動追記されます)
### A1: フレームワーク明示

- **入力**: Next.jsでブログアプリを作りたい
- **期待**: nextjs-developer
- **選択**: ci-cd-fixer,code-reviewer,error-recovery,llm-architect,nextjs-developer,python-pro,terraform-engineer
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
# エージェント選択の回答

各タスクに最適なエージェントを以下に示します：

---

## Next.jsでブログアプリを作りたい
**subagent_type: `nextjs-developer`**

理由: Next.js 14+ App Router、サーバーコンポーネント、パフォーマンス最適化に特化したエージェント

---

## A2: Pythonで画像処理スクリプトを書いて
**subagent_type: `python-pro`**

理由: Python 3.11+のエコシステム全般（Web、データサイエンス、自動化）の専門家

---

## A3: Terraformでマルチリージョン構成を作りたい
**subagent_type: `terraform-engineer`**

理由: Infrastructure as Code、マルチクラウド、モジュール設計の専門家

---

## A4: このコードをレビューして
**subagent_type: `code-reviewer`**

理由: セキュリティ/性能/品質を多角的にレビューする専門エージェント

---

## A5: CIが落ちてる、直して
**subagent_type: `ci-cd-fixer`**

理由: CI失敗時の診断・修正を安全第一で支援するエージェント

---

## A6: エラーが出て動かない
**subagent_type: `error-recovery`**

理由: エラー復旧（原因切り分け→安全な修正→再検証）の専門家

---

## A7: RAGシステムを設計したい
**subagent_type: `llm-architect`**
```

</details>

---

### A2: 言語明示

- **入力**: Pythonで画像処理スクリプトを書いて
- **期待**: python-pro
- **選択**: subagent_type="python-pro
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
## 推奨エージェント

**`python-pro`** を使用すべきです。

### 理由

```
subagent_type: "python-pro"
```

このエージェントは以下の特徴を持っています：

- **Python 3.11+ のエコシステム全般**（Web、データサイエンス、自動化）の専門家
- 画像処理は Python のデータサイエンス/自動化領域に該当
- `Read`, `Write`, `Edit`, `Bash`, `Glob`, `Grep` ツールにアクセス可能

### 使用例

```python
# Taskツールの呼び出し
Task(
    subagent_type="python-pro",
    prompt="PILを使って画像をリサイズするスクリプトを書いて",
    description="Write image processing script"
)
```

### 補足

- 画像処理ライブラリ（Pillow, OpenCV, scikit-image など）の実装は `python-pro` の守備範囲
- UI コンポーネントが必要な場合は `ui` スキルと組み合わせることも可能
- 機械学習ベースの画像処理（物体検出など）も `python-pro` で対応可能
```

</details>

---

### A3: ツール明示

- **入力**: Terraformでマルチリージョン構成を作りたい
- **期待**: terraform-engineer
- **選択**: terraform-engineer
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
ご質問ありがとうございます。

Terraformでマルチリージョン構成を作成する場合、使用すべきエージェントは：

## **subagent_type: `terraform-engineer`**

このエージェントは以下の専門性を持っています：
- **Infrastructure as Code** - Terraformの専門知識
- **マルチクラウド** - 複数のクラウドプロバイダーに対応
- **モジュール設計** - 再利用可能なTerraformモジュールの設計

マルチリージョン構成の計画・実装において、このエージェントが最適です。
```

</details>

---

### A4: タスク明示

- **入力**: このコードをレビューして
- **期待**: code-reviewer
- **選択**: code-reviewer,refactoring-specialist
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
## コードレビュー結果

### 使うべきエージェント: `code-reviewer`

```
subagent_type: "code-reviewer"
```

### 理由

1. **タスクの性質**: 「このコードをレビューして」という明確なコードレビュー依頼
2. **エージェント説明との一致**: `code-reviewer`は「セキュリティ/性能/品質を多角的にレビュー」と定義されており、まさにこのタスクに該当
3. **実装は不要**: レビューのみで修正作業は含まれていないため、`refactoring-specialist`などは不要

---

### コードの所見（参考）

**test-cases.json**
- エージェント選択のテストケースを18件定義
- カテゴリ分け（single-select, ambiguous, multi-agent, edge-case）が明確

**run-tests.sh**
- Claude CLIを使ったテスト自動実行スクリプト
- jqとclaude CLIへの依存あり
- 結果をMarkdownファイルに出力

**潜在的な改善点**（実装は不要とのことなので参考まで）:
- `run-tests.sh:170-183`: whileループ内でpass/fail/skipをカウントしているが、サブシェルで実行されるため変数が親シェルに反映されない
- `run-tests.sh:78-83`: grep/sedでのエージェント抽出が複雑で、正規表現の組み合わせが壊れやすい
```

</details>

---

### A5: 緊急対応

- **入力**: CIが落ちてる、直して
- **期待**: ci-cd-fixer
- **選択**: ci-cd-fixer,error-recovery
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
CIが落ちている場合に使うべきエージェントについて回答します。

## 推奨エージェント

**`subagent_type: "ci-cd-fixer"`**

### 理由

`ci-cd-fixer` エージェントは以下の説明を持っています：

> CI失敗時の診断・修正を安全第一で支援 (Tools: [Read, Write, Bash, Grep, Glob])

このエージェントは：
- CI/CDパイプラインの失敗を診断
- エラーの原因を特定
- 安全に修正を適用

という目的に特化しています。

### 代替オプション

状況によっては以下も検討できます：

| subagent_type | 使用ケース |
|---------------|-----------|
| `error-recovery` | エラー復旧全般（原因切り分け→安全な修正→再検証） |
| `verify` | ビルド検証、テスト実行、lint エラー、型エラーの修正 |

### スキルの利用

また、プロジェクトには `/ci` スキルも用意されており、これも CI/CD パイプラインの失敗を診断・修正するために使えます。

---

**結論**: CI が落ちている場合は **`ci-cd-fixer`** を使ってください。
```

</details>

---

### A6: 障害対応

- **入力**: エラーが出て動かない
- **期待**: error-recovery
- **選択**: subagent_type="error-recovery,subagent_type="error-recovery
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
スクリプトを実行して確認する必要がありますが、承認が必要なようです。

では、**エラーの種類によって使うべきエージェント**をお答えします：

---

## 推奨エージェント

### **`subagent_type="error-recovery"`**

このエージェントが最適です。理由：

1. **説明**: `エラー復旧（原因切り分け→安全な修正→再検証）`
2. **ツール**: `Read, Write, Edit, Bash, Grep, Glob` - エラー調査と修正に必要なツールが揃っている
3. **目的**: まさに「エラーが出て動かない」という状況の診断・修正に特化

---

## 補足：他の候補

状況によっては以下も検討できます：

| 状況 | subagent_type |
|------|---------------|
| CI/CDパイプラインのエラー | `ci-cd-fixer` |
| TypeScriptの型エラー | `typescript-pro` |
| Pythonのエラー | `python-pro` |
| ビルド検証・エラー復旧 | スキル `/verify` |

---

## 結論

**`subagent_type="error-recovery"`** を使用してください。
```

</details>

---

### A7: AI専門

- **入力**: RAGシステムを設計したい
- **期待**: llm-architect
- **選択**: llm-architect,mcp-developer,python-pro,typescript-pro
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
RAGシステムの設計には、以下のエージェントが適切です：

## 推奨エージェント

### 1. **`llm-architect`** (最も推奨)
```
subagent_type: "llm-architect"
```
- **専門領域**: LLMアーキテクチャ設計、RAG実装、モデル最適化、本番デプロイ
- **理由**: RAGシステムはLLMアーキテクチャの中核的なパターンであり、このエージェントはRAG実装を専門としています

### 2. **`Plan`** (設計フェーズ)
```
subagent_type: "Plan"
```
- **専門領域**: 実装計画の設計、アーキテクチャのトレードオフ検討
- **理由**: 実装前の設計段階で、ステップバイステップの計画を立てるのに最適

---

## 補助的に使えるエージェント

| subagent_type | 用途 |
|---------------|------|
| `python-pro` | Python でのRAG実装（LangChain, LlamaIndex等） |
| `typescript-pro` | TypeScript でのRAG実装 |
| `mcp-developer` | MCPサーバーとしてRAGを提供する場合 |

---

## 結論

**設計のみ**であれば:
- **`llm-architect`** を使用してください

このエージェントがRAG特有の設計判断（チャンキング戦略、埋め込みモデル選択、ベクトルDB選定、リトリーバル戦略、リランキング等）に最も精通しています。
```

</details>

---

### B1: 追加質問するか確認

- **入力**: フロントエンドを作りたい
- **期待**: nextjs-developer,typescript-pro
- **選択**: nextjs-developer,refactoring-specialist,typescript-pro
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
フロントエンド開発に適したエージェントは以下の通りです：

## 推奨エージェント

### 1. **`nextjs-developer`** (最も推奨)
- **subagent_type**: `nextjs-developer`
- Next.js 14+ App Router、サーバーコンポーネント、サーバーアクション、パフォーマンス最適化に特化
- React + Next.js のフルスタック開発に最適

### 2. **`typescript-pro`**
- **subagent_type**: `typescript-pro`
- TypeScript 5.0+ の高度な型システム、型安全性に特化
- フロントエンドの型定義やビルド最適化に有効

### 3. **`refactoring-specialist`**
- **subagent_type**: `refactoring-specialist`
- 既存フロントエンドコードの安全なリファクタリング、デザインパターン適用

---

## スキル（Skill）も活用可能

プロジェクトには以下のスキルも設定されています：

- **`/ui`** - UIコンポーネント、ヒーロー、フォーム、フィードバック生成
- **`/ui-ux-pro-max`** - 50スタイル、21パレット、React/Next.js/Vue/Svelte等対応のUI/UXデザイン

---

## 選択の指針

| ユースケース | 推奨 subagent_type |
|------------|-------------------|
| Next.js アプリ開発 | `nextjs-developer` |
| React + TypeScript の型設計 | `typescript-pro` |
| 既存コードのリファクタリング | `refactoring-specialist` |
| 汎用的な調査・実装 | `general-purpose` |

**結論**: Next.js/React ベースのフロントエンドなら **`nextjs-developer`** を使用してください。
```

</details>

---

### B2: 文脈判断

- **入力**: インフラを構築したい
- **期待**: kubernetes-specialist,terraform-engineer
- **選択**: ci-cd-fixer,kubernetes-specialist,terraform-engineer
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
インフラ構築のタスクには、以下のエージェントが適しています：

## 推奨エージェント

### 1. **`terraform-engineer`** (最も推奨)
Infrastructure as Code、マルチクラウド、モジュール設計の専門家です。

```
subagent_type: "terraform-engineer"
```

**適用シナリオ：**
- Terraform/OpenTofu でのインフラ定義
- AWS/GCP/Azure などマルチクラウド構成
- モジュール設計とベストプラクティス

---

### 2. **`kubernetes-specialist`**
コンテナオーケストレーション、クラウドネイティブアーキテクチャの専門家です。

```
subagent_type: "kubernetes-specialist"
```

**適用シナリオ：**
- Kubernetes クラスタ管理
- Helm チャート作成
- コンテナ化されたアプリのデプロイ

---

## 選び方の目安

| やりたいこと | subagent_type |
|-------------|---------------|
| Terraform でインフラを定義したい | `terraform-engineer` |
| AWS/GCP/Azure のリソースを構築したい | `terraform-engineer` |
| Kubernetes クラスタを構築・管理したい | `kubernetes-specialist` |
| Docker/コンテナのデプロイ設計 | `kubernetes-specialist` |
| CI/CD パイプラインの構築 | `ci-cd-fixer` |

---

具体的にどのようなインフラを構築したいか教えていただければ、より適切なエージェントを特定できます。
```

</details>

---

### B3: タスク種別判断

- **入力**: コードを改善したい
- **期待**: refactoring-specialist,code-reviewer
- **選択**: code-reviewer,refactoring-specialist
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
## 回答: 「コードを改善したい」に適したエージェント

この入力はテストケース **B3** に該当し、**曖昧なリクエスト** です。

### 推奨 subagent_type（優先度順）:

| subagent_type | 用途 |
|---------------|------|
| **`refactoring-specialist`** | コードの安全な変換、デザインパターン適用、レガシーコード改善 |
| **`code-reviewer`** | セキュリティ/性能/品質の多角的レビュー |

### 判断基準:

- **改善 = 構造的な変更**（リファクタリング）なら → `refactoring-specialist`
- **改善 = 問題点の指摘**（レビュー）なら → `code-reviewer`

### 理想的な対応:

このリクエストは曖昧なので、まず **AskUserQuestion** ツールで以下を確認するのがベストです：

- 「具体的にどのような改善ですか？（リファクタリング / コードレビュー / パフォーマンス最適化 など）」
- 対象のコードやファイルは何か

その回答に基づいて適切なエージェントを選択します。
```

</details>

---

### B4: 技術選定質問

- **入力**: APIを作りたい
- **期待**: nextjs-developer,python-pro
- **選択**: nextjs-developer,python-pro,typescript-pro
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
APIを作成する場合、目的や技術スタックによって適切なエージェントが異なります。

## 推奨されるエージェント

### 1. **`python-pro`** - Python API の場合
Python 3.11+ のエコシステム全般（Web、データサイエンス、自動化）の専門家です。
- FastAPI、Flask、Django REST Framework などを使う場合に最適

### 2. **`nextjs-developer`** - Next.js API Routes の場合
Next.js 14+ の App Router とフルスタック機能の専門家です。
- Next.js の API Routes や Server Actions を使う場合に最適

### 3. **`typescript-pro`** - TypeScript API の場合
TypeScript 5.0+ の高度な型システム、フルスタック型安全性の専門家です。
- Express.js、Hono、NestJS など TypeScript ベースの API を使う場合に最適

### 4. **`general-purpose`** - 汎用的な場合
複雑な質問の調査、コード検索、マルチステップタスクに対応する汎用エージェントです。
- 技術スタックが未定の場合や、複数の選択肢を比較検討したい場合に最適

---

## 選び方のポイント

| 技術スタック | subagent_type |
|-------------|---------------|
| Python (FastAPI, Flask, Django) | `python-pro` |
| Next.js API Routes | `nextjs-developer` |
| TypeScript (Express, NestJS, Hono) | `typescript-pro` |
| 未定・比較検討 | `general-purpose` |

どの技術スタックでAPIを作成予定ですか？
```

</details>

---

### C1: 順序性が重要

- **入力**: Next.jsアプリをK8sにデプロイしたい
- **期待**: nextjs-developer,kubernetes-specialist
- **選択**: ci-cd-fixer,kubernetes-specialist,nextjs-developer,terraform-engineer
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
ご質問ありがとうございます。Next.jsアプリをKubernetesにデプロイする場合、複数のエージェントが関連しますが、タスクの段階によって使い分けます。

## 推奨エージェント

### 1. **計画段階**
```
subagent_type: "Plan"
```
- 実装戦略の設計、アーキテクチャの検討に使用

### 2. **Next.js アプリ開発**
```
subagent_type: "nextjs-developer"
```
- Next.js 14+ App Router、サーバーコンポーネント、本番デプロイ向け最適化

### 3. **Kubernetes マニフェスト作成・クラスタ管理**
```
subagent_type: "kubernetes-specialist"
```
- プロダクション級クラスタ管理、コンテナオーケストレーション、クラウドネイティブアーキテクチャ

### 4. **Terraform での IaC（インフラ構築）**
```
subagent_type: "terraform-engineer"
```
- Infrastructure as Code、マルチクラウド、モジュール設計

---

## 典型的な使い分け

| タスク | subagent_type |
|--------|---------------|
| デプロイ戦略の計画 | `Plan` |
| Next.js の Dockerfile 作成・最適化 | `nextjs-developer` |
| K8s Deployment/Service/Ingress 作成 | `kubernetes-specialist` |
| GKE/EKS などのクラスタ構築（Terraform） | `terraform-engineer` |
| CI/CD パイプライン修正 | `ci-cd-fixer` |

---

**メインで使うべきは `kubernetes-specialist`** です。Next.js固有の設定（Dockerfileなど）が必要な場合は `nextjs-developer` と併用してください。
```

</details>

---

### C2: 依存関係

- **入力**: 新規プロジェクトをセットアップしてレビューして
- **期待**: project-scaffolder,code-reviewer
- **選択**: code-reviewer,project-analyzer,project-scaffolder
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
ご質問にお答えします。

## エージェント選択の推奨

### 1. 新規プロジェクトのセットアップ

**推奨: `subagent_type: "setup"`**

```
skill: setup
```

理由:
- 新規プロジェクトの初期化に特化
- CLAUDE.md、AGENTS.md、Plans.md などのワークフローファイル生成
- トリガーワード: セットアップ, setup, 初期化, initialize, 新規プロジェクト

### 2. コードレビュー

**推奨: `subagent_type: "code-reviewer"`**

```
Task tool with subagent_type: "code-reviewer"
```

理由:
- セキュリティ/パフォーマンス/品質を多角的にレビュー
- 読み取り専用ツール（Read, Grep, Glob, Bash）のみ使用
- 実装は行わず、レビューに専念

---

## 代替・補完オプション

| タスク | subagent_type | 用途 |
|--------|---------------|------|
| プロジェクト分析 | `project-analyzer` | 新規/既存プロジェクト判定、技術スタック検出 |
| レビュー（スキル経由） | skill: `review` | セキュリティ、パフォーマンス、アクセシビリティ |
| レビュー（ハーネス経由） | skill: `core:harness-review` | 組み込みreviewとの衝突回避 |

---

## まとめ

```
# セットアップ
Skill tool → skill: "setup"
または
Task tool → subagent_type: "project-scaffolder"（指定スタックでプロジェクト自動生成）
```

</details>

---

### C3: 協調（順序不問）

- **入力**: LLMアプリのプロンプトを最適化したい
- **期待**: llm-architect,prompt-engineer
- **選択**: code-reviewer,llm-architect,prompt-engineer
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
ご質問ありがとうございます。LLMアプリのプロンプト最適化には、以下のエージェントが最適です：

## 推奨エージェント

### `prompt-engineer`
```
subagent_type: "prompt-engineer"
```

**理由：**
このエージェントは「プロンプト設計、最適化、評価、本番運用の専門家」として設計されており、まさにプロンプト最適化のためのエージェントです。

---

### 補助的に使えるエージェント

| subagent_type | 用途 |
|---------------|------|
| `llm-architect` | LLMアーキテクチャ全体の設計、RAG実装、モデル最適化が必要な場合 |
| `code-reviewer` | 既存のプロンプト実装コードのレビューが必要な場合 |

---

**結論：** プロンプト最適化単体であれば **`prompt-engineer`** を使ってください。
```

</details>

---

### C4: 連鎖

- **入力**: 既存コードをリファクタしてCIを通して
- **期待**: refactoring-specialist,ci-cd-fixer
- **選択**: ci-cd-fixer,error-recovery,nextjs-developer,python-pro,refactoring-specialist,typescript-pro
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
ご質問ありがとうございます。既存コードのリファクタリングとCI通過のためのエージェント選択について回答します。

## 推奨するエージェントと使用順序

### 1. リファクタリング作業
**`subagent_type: "refactoring-specialist"`**

- 安全なコード変換
- デザインパターン適用
- レガシーコード改善
- テスト維持しながらの段階的実行

### 2. CI失敗時の診断・修正
**`subagent_type: "ci-cd-fixer"`**

- CI失敗時の診断・修正を安全第一で支援
- GitHub Actions, GitLab CI などのパイプライン問題に対応
- ビルドエラー、テスト失敗の分析

### 3. エラー復旧（必要に応じて）
**`subagent_type: "error-recovery"`**

- エラーの原因切り分け
- 安全な修正
- 再検証

---

## 作業フローの例

```
1. refactoring-specialist でリファクタリング実施
     ↓
2. ci-cd-fixer でCI実行・結果確認
     ↓
3. （CI失敗時）error-recovery または ci-cd-fixer で修正
     ↓
4. 繰り返し → CI通過
```

---

## 補足：言語別の専門エージェント

リファクタリング対象のコードが特定言語の場合、以下も併用可能です：

| 言語 | subagent_type |
|------|---------------|
| TypeScript | `typescript-pro` |
| Python | `python-pro` |
```

</details>

---

### D1: 該当エージェントなし→汎用対応 or 質問

- **入力**: Rustでシステムを作りたい
- **期待**: 
- **選択**: ci-cd-fixer,code-reviewer,error-recovery,kubernetes-specialist,llm-architect,mcp-developer,nextjs-developer,prompt-engineer,python-pro,refactoring-specialist,terraform-engineer,typescript-pro
- **結果**: FAIL

<details>
<summary>出力詳細</summary>

```
ご質問ありがとうございます。

現在利用可能なsubagent_typeを確認すると、**Rust専用のエージェントは存在しません**。

## 利用可能なsubagent_type一覧

| subagent_type | 専門領域 |
|---------------|----------|
| `general-purpose` | 汎用的なタスク、コード検索、複雑なマルチステップタスク |
| `Explore` | コードベース探索（ファイル検索、キーワード検索） |
| `Plan` | 実装計画の設計 |
| `typescript-pro` | TypeScript 5.0+ |
| `python-pro` | Python 3.11+ |
| `nextjs-developer` | Next.js 14+ |
| `kubernetes-specialist` | Kubernetes/コンテナ |
| `terraform-engineer` | Infrastructure as Code |
| `refactoring-specialist` | リファクタリング |
| `error-recovery` | エラー復旧 |
| `ci-cd-fixer` | CI/CD修正 |
| `llm-architect` | LLMアーキテクチャ設計 |
| `mcp-developer` | MCP開発 |
| `code-reviewer` | コードレビュー |
| `prompt-engineer` | プロンプト設計 |
| その他... | |

## Rustシステム開発の推奨

Rustでシステムを作る場合は、以下のsubagent_typeを組み合わせて使うことをお勧めします：

1. **`general-purpose`** - Rust開発全般のサポート
2. **`Plan`** - 実装計画の策定
3. **`code-reviewer`** - コードレビュー
4. **`refactoring-specialist`** - リファクタリング（言語非依存の原則適用）

**結論**: Rust専用エージェントがないため、**`general-purpose`** を主に使用してください。
```

</details>

---

### D2: 曖昧すぎる→質問必須

- **入力**: なんかいい感じにして
- **期待**: 
- **選択**: code-reviewer,refactoring-specialist
- **結果**: FAIL

<details>
<summary>出力詳細</summary>

```
なるほど！これはテストケース **D2** ですね。「なんかいい感じにして」という曖昧すぎるリクエストに対して、**質問が必須** とされています。

## 回答

**「なんかいい感じにして」** は曖昧すぎるため、まず **質問をして明確化する必要があります**。

### 判断根拠

このリクエストには以下の情報が欠けています：
- **何を**いい感じにしたいのか（コード？ドキュメント？プロジェクト構成？）
- **どのように**いい感じにしたいのか（リファクタ？レビュー？整理？）
- **対象**は何か（特定のファイル？ディレクトリ全体？）

### 適切な対応

このケースでは **AskUserQuestion ツール** を使って質問すべきです。

確認すべき内容の例：
1. 何を改善したいですか？（コード / ドキュメント / プロジェクト構成）
2. どのような改善を期待していますか？（リファクタリング / レビュー / 整理・クリーンアップ）
3. 対象のファイルやディレクトリはありますか？

---

### 仮に回答を推測する場合の候補

もし強いて選ぶなら、文脈（`results.md` を見ていた）から以下が考えられます：

| 可能性 | subagent_type | 理由 |
|--------|---------------|------|
| results.md の整理 | `general-purpose` | 汎用タスク |
| コードの改善 | `refactoring-specialist` | 安全なリファクタリング |
| 品質チェック | `code-reviewer` | 多角的レビュー |

**結論**: このリクエストには **質問が必須** であり、即座にエージェントを選択すべきではありません。
```

</details>

---

### D3: 2つ該当→優先度判断 (nextjs > ts-pro)

- **入力**: TypeScriptでNext.jsアプリを
- **期待**: nextjs-developer
- **選択**: nextjs-developer,typescript-pro
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
TypeScriptでNext.jsアプリを開発する場合、以下のエージェントが適切です：

## 推奨エージェント

### 1. **`nextjs-developer`** (最も推奨)
```
subagent_type: "nextjs-developer"
```
- Next.js 14+ の App Router、Server Components、Server Actions に特化
- パフォーマンス最適化、SEO対応、本番デプロイに強い
- TypeScriptとの組み合わせで最適

### 2. **`typescript-pro`**
```
subagent_type: "typescript-pro"
```
- TypeScript 5.0+ の高度な型システム、フルスタック型安全性に特化
- 複雑な型定義やビルド最適化が必要な場合

### 3. **`Explore`**
```
subagent_type: "Explore"
```
- 既存のNext.jsコードベースを調査・理解する場合
- ファイル構造やAPIエンドポイントの把握に最適

### 4. **`Plan`**
```
subagent_type: "Plan"
```
- 実装前のアーキテクチャ設計・計画立案
- 複雑な機能の実装戦略を決める場合

---

## 使い分けの目安

| 目的 | subagent_type |
|------|---------------|
| Next.js機能の実装（ルーティング、SSR、API Routes等） | `nextjs-developer` |
| 複雑なTypeScript型定義・型安全性の強化 | `typescript-pro` |
| 既存コードの調査・理解 | `Explore` |
| 設計・計画の策定 | `Plan` |
| 一般的な実装タスク | `general-purpose` |

**結論**: Next.jsアプリ開発には **`nextjs-developer`** を第一選択として使用してください。
```

</details>

---

### D4: 組み合わせ

- **入力**: MCPサーバーをPythonで作りたい
- **期待**: mcp-developer,python-pro
- **選択**: mcp-developer,python-pro
- **結果**: PASS

<details>
<summary>出力詳細</summary>

```
MCPサーバーをPythonで作成する場合、以下のエージェントが適切です：

## 推奨エージェント

### 1. **`mcp-developer`** (最も適切)
```
subagent_type: "mcp-developer"
```
- **理由**: Model Context Protocol のサーバー/クライアント開発、プロトコル実装の専門家
- MCP固有の知識（ツール定義、リソース、プロンプトなど）を持つ

### 2. **`python-pro`** (補助的に)
```
subagent_type: "python-pro"
```
- **理由**: Python 3.11+ のエコシステム全般（Web、自動化など）の専門家
- Pythonの実装詳細やベストプラクティスに強い

---

## 使い分け

| 目的 | subagent_type |
|------|---------------|
| MCPプロトコルの設計・構造理解 | `mcp-developer` |
| Python実装の詳細・ライブラリ選定 | `python-pro` |
| 両方を並列で調査 | 両方を同時に起動 |

**結論**: MCPサーバー開発には **`mcp-developer`** を第一選択とし、Python固有の実装課題があれば **`python-pro`** を併用するのがベストです。
```

</details>

---

