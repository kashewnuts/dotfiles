# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

個人用dotfilesリポジトリ。macOS、Linux、Windows（MSYS/WSL）に対応したシェル、Vim、Git、tmuxなどの設定ファイルを管理。

## セットアップコマンド

```bash
# dotfilesのセットアップ（シンボリックリンク作成）
python3 setup.py

# GitHub Codespaces用ブートストラップ
./bootstrap.sh

# Homebrewパッケージのインストール（macOS）
brew bundle --file=brewfile
```

## 構成

### setup.py
- `DOT_FILES`: ホームディレクトリにシンボリックリンクを作成するファイル一覧
- `CONFIG_DIRS`: 作成するディレクトリ（`.cache/tmp`, `.config`）
- `CONFIG_FILES`: `.config/`以下に配置する設定ファイル（flake8, mypy）
- OS判定でWindows/Unix固有の設定を切り替え（`.gitconfig.os`など）

### プラットフォーム固有の設定
- `.bashrc`: `$OSTYPE`で darwin/msys/linux を判別してエイリアスや環境変数を設定
- `.tmux.conf`: `if-shell`でOS別設定ファイル（`.tmux.conf.linux`, `.tmux.conf.wsl`, `.tmux.conf.osx`）を読み込み
- `.gitconfig`: `[include]`で`.gitconfig.os`と`.gitconfig.local`を読み込み

### Vim設定（.vim/）
- `vimrc`: メイン設定。vim-plugでプラグイン管理、coc.nvimでLSP対応
- `minimal.vim`: 最小構成のvim設定（viエイリアス用）
- `coc-settings.json`: coc.nvimの言語サーバー設定
- `after/ftplugin/`: ファイルタイプ別設定
- `ftdetect/`: ファイルタイプ検出ルール

### ローカル設定ファイル（git管理外）
- `~/.vimrc.local`: Vim用ローカル設定
- `~/.bash_local`: Bash用ローカル設定
- `~/.gitconfig.local`: Git用ローカル設定

## 主要なエイリアス

```bash
g='git'
v='vim'
d='docker'
dcp='docker-compose'
frepo='fzf-repo'  # ghqリポジトリをfzfで選択
```

## Vimキーマッピング

- `<Space>`: Leader
- `<C-p>`: ファイル検索（fzf/CtrlP）
- `<Leader>fb`: バッファ一覧
- `<Leader>fm`: 最近使用したファイル
- `gc`/`gcc`: コメントトグル（caw.vim）
- `ga`: EasyAlign
- `ge`: ファイルエクスプローラ（coc-explorer）
