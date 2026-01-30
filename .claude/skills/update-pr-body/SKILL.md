---
name: update-pr-body
description: GitHub PRのURLを指定して、変更内容に基づいたPR本文を生成・更新する
argument-hint: <PR URL or PR number>
disable-model-invocation: true
allowed-tools: Bash(gh:*)
---

# PR 本文更新

GitHub PR の URL を指定して、変更内容に基づいた PR 本文を生成・更新する。

## 入力

`$ARGUMENTS` = PR URL (例: `https://github.com/owner/repo/pull/123`) または PR 番号

## 手順

1. **PR 情報の取得**
   - `gh pr view $ARGUMENTS --json number,title,body,baseRefName,headRefName,commits,files`
   - 現在の PR 本文と変更内容を取得

2. **変更内容の分析**
   - `gh pr diff $ARGUMENTS` で差分を取得
   - 変更されたファイルと内容を分析
   - 変更の種類を分類（機能追加/バグ修正/リファクタリング/ドキュメント等）

3. **コミット履歴の確認**
   - `gh pr view $ARGUMENTS --json commits` でコミット一覧を取得
   - コミットメッセージから変更の意図を把握

4. **PR 本文の生成**
   以下のフォーマットで本文を生成:

   ```markdown
   ## 概要

   [変更の目的と背景を1-2文で説明]

   ## 変更内容

   - [主要な変更点1]
   - [主要な変更点2]
   - [主要な変更点3]

   ## 技術的詳細

   [実装のアプローチや技術的な決定事項]

   ## テスト

   - [ ] ユニットテスト
   - [ ] 手動テスト
   - [ ] 既存テストの確認

   ## レビューポイント

   - [レビュアーに特に見てほしい点1]
   - [レビュアーに特に見てほしい点2]

   ## 関連 Issue

   - Close #XXX (該当する場合)
   ```

5. **既存本文との比較**
   - 現在の PR 本文と生成した本文を比較
   - 既存の本文がある場合は、重要な情報を保持するか確認

6. **PR 本文の更新**
   - ユーザーに生成した本文を提示
   - 承認後、`gh pr edit $ARGUMENTS --body "..."` で更新
   - HEREDOC を使用して複数行の本文を渡す:
     ```bash
     gh pr edit $ARGUMENTS --body "$(cat <<'EOF'
     [生成した本文]
     EOF
     )"
     ```

7. **更新完了の確認**
   - `gh pr view $ARGUMENTS --json body` で更新を確認
   - PR URL を出力

## 注意事項

- 既存の PR 本文に重要な情報がある場合は保持する
- 日本語プロジェクトでは日本語で、英語プロジェクトでは英語で記述
- 機密情報や内部リンクは含めない
- Close/Fix/Resolve キーワードは関連 Issue がある場合のみ使用
