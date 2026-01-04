---
description: コミット、プッシュ、PR作成を一括実行
description-en: Commit, push, and create PR in one command
---

# /commit-push-pr - Daily Workflow Command

変更をコミット、プッシュし、必要に応じてPRを作成する日常ワークフローコマンド。

## VibeCoder 向け（こう言えばOK）

- 「**コミットしてプッシュして**」→ このコマンド
- 「**PRも作って**」→ PR作成まで実行
- 「**ドラフトPRで**」→ Draft PRとして作成
- 「**プッシュだけでいい**」→ PR作成はスキップ

## できること

- ステージング確認と差分分析
- Conventional Commits形式のメッセージ自動生成
- リモートへのプッシュ（ブランチがなければ作成）
- PR作成（Summary + Test Plan形式）

---

## オプション

| オプション | 効果 |
|-----------|------|
| (デフォルト) | コミット → プッシュ → PR作成 |
| `--draft` | Draft PRとして作成 |
| `--no-pr` | PRは作成せず、コミットとプッシュのみ |
| `--amend` | 直前のコミットを修正（未プッシュの場合のみ） |

---

## 実行フロー

### Step 1: 現状確認

```bash
git status
git diff --staged
git diff
git log --oneline -5
```

変更内容を分析し、コミット対象を特定。

### Step 2: コミットメッセージ生成

Conventional Commits形式で自動生成：

| 変更タイプ | Prefix | 例 |
|-----------|--------|-----|
| 新機能 | `feat:` | `feat: add user authentication` |
| バグ修正 | `fix:` | `fix: resolve login redirect loop` |
| リファクタ | `refactor:` | `refactor: simplify auth logic` |
| ドキュメント | `docs:` | `docs: update API documentation` |
| テスト | `test:` | `test: add unit tests for auth` |
| ビルド/CI | `chore:` | `chore: update dependencies` |

### Step 3: コミット実行

```bash
git add -A
git commit -m "$(cat <<'EOF'
feat: add user authentication

- Implement login/logout flow
- Add session management
- Create auth middleware

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### Step 4: プッシュ

```bash
# ブランチがリモートに存在しない場合
git push -u origin HEAD

# 存在する場合
git push
```

### Step 5: PR作成（オプション）

```bash
gh pr create --title "feat: add user authentication" --body "$(cat <<'EOF'
## Summary
- Implement login/logout flow with session management
- Add auth middleware for protected routes
- Create user profile component

## Test plan
- [ ] Login with valid credentials
- [ ] Logout and verify session cleared
- [ ] Access protected route without auth (should redirect)
- [ ] Access protected route with auth (should succeed)

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

---

## 安全ガード

### 禁止操作（自動ブロック）

| 操作 | 理由 |
|------|------|
| `--force` push | 履歴破壊を防止 |
| main/master への直接push | PRワークフロー強制 |
| `--amend` (プッシュ済み) | 履歴書き換え防止 |
| secrets ファイルのコミット | .env, credentials.json など |

### 警告表示（確認後続行）

| 条件 | 警告内容 |
|------|---------|
| 大量の変更（100+ files） | 分割コミットを推奨 |
| バイナリファイル含む | 意図的か確認 |
| 新規ブランチ作成時 | ブランチ名を確認 |

---

## 実行例

### 基本的な使用

```
📋 変更を確認中...

変更ファイル: 5件
├── src/auth/login.ts (追加)
├── src/auth/logout.ts (追加)
├── src/middleware/auth.ts (追加)
├── src/components/Profile.tsx (追加)
└── package.json (変更)

📝 コミットメッセージ案:

  feat: add user authentication

  - Implement login/logout endpoints
  - Add auth middleware
  - Create Profile component

このメッセージでコミットしますか？ [Y/n/edit]
```

### PR作成まで完了

```
✅ コミット完了: feat: add user authentication
✅ プッシュ完了: origin/feature/auth
✅ PR作成完了: #42

🔗 https://github.com/user/repo/pull/42
```

---

## トラブルシューティング

### コンフリクト発生時

```
⚠️ プッシュ失敗: リモートに新しいコミットがあります

対応オプション:
1. git pull --rebase して再試行
2. 変更を確認してマージ
3. 一旦キャンセル

どうしますか？
```

### PRが既に存在する場合

```
⚠️ この変更の PR は既に存在します: #40

対応オプション:
1. 既存PRに追加コミットをプッシュ
2. 新しいPRを作成（ブランチ名変更）
3. キャンセル
```

---

## VibeCoder 向けヒント

| やりたいこと | 言い方 |
|-------------|--------|
| 全部まとめてコミット | 「変更をコミットして」 |
| メッセージを自分で書く | 「メッセージは〇〇で」 |
| ドラフトPRにしたい | 「まだレビュー前だからドラフトで」 |
| PRの説明を追加 | 「PRの説明に〇〇を追加して」 |
