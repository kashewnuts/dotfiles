---
name: optimize-slow-query
description: 遅いSQLクエリを特定し、パフォーマンス最適化案をドキュメント化する。SQLクエリ最適化が必要な場合に使用。
argument-hint: <SQL query or query description>
allowed-tools: Read, Grep, Glob, Write, Bash(docker:*)
---

# Optimize Slow Query

遅いSQLクエリを特定し、パフォーマンス最適化案を日本語でドキュメント化します。

## 手順

1. 提供されたSQLクエリを解析し、使用されているテーブルとカラムを特定

2. クエリパターンから発生箇所を特定
   - Grepツールで関連するDjango ORMコードを検索
   - annotate、filter、aggregate、select_relatedなどのパターンを探索
   - モデル定義とビュー、API関数を調査

3. 既存のインデックスを確認
   - `docker compose exec app python manage.py shell`を使用
   - 各テーブルの現在のインデックスを`SHOW INDEX FROM table_name`で確認
   - ForeignKeyによる自動インデックスも考慮

4. パフォーマンス問題の原因を分析
   - インデックスの欠如または不適切な複合インデックス
   - N+1問題の可能性
   - 不要なJOINやサブクエリ
   - 大量データの全件取得
   - GROUP BYやORDER BYの非効率性

5. 段階的な改善提案を作成
   - Phase 1: インデックス追加（即効性高、リスク低）
   - Phase 2: クエリ最適化（中期的改善）
   - Phase 3: キャッシュ実装（長期的改善）

6. 具体的な実装例を提供
   - マイグレーションファイルのサンプルコード
   - 最適化されたDjango ORMクエリ
   - キャッシュ実装のコード例

7. 期待される効果を数値化
   - 現状の実行時間
   - 各Phaseごとの改善目標
   - 最終的な目標（10ms以内）

8. ドキュメントをdocsディレクトリに日本語で出力
   - ファイル名: `{機能名}_query_optimization.md`
   - 問題の概要、原因分析、改善提案、実装例を含む
   - リスクと注意事項、テスト項目も記載

## 引数の使用

$ARGUMENTSにSQLクエリが含まれる場合、そのクエリを最適化対象として処理します。

## 例

```sql
SELECT * FROM large_table
WHERE status = 'active'
ORDER BY created_at DESC
```

このようなクエリに対して：
- `(status, created_at)` の複合インデックス追加を提案
- `only()` での必要フィールド制限を提案
- Redisキャッシュの実装例を提供
