# エージェント選択テスト結果

**実行日時**: (未実行)
**テストスイート**: agent-selection

---

## サマリー

| カテゴリ | Pass | Fail | Skip | 合計 |
|---------|------|------|------|------|
| A: single-select | - | - | - | 7 |
| B: ambiguous | - | - | - | 4 |
| C: multi-agent | - | - | - | 4 |
| D: edge-case | - | - | - | 4 |
| **合計** | - | - | - | 19 |

---

## 成功基準

| レベル | 基準 | 達成 |
|-------|------|-----|
| 必須 | A（単一選択）で80%以上正解 | - |
| 推奨 | B（曖昧要件）で適切な質問または妥当な選択 | - |
| 理想 | C（複数連携）で正しい順序・組み合わせ | - |

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
