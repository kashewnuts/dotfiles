import sys
from pathlib import Path

HOME_DIR = Path.home()
BASE_DIR = Path(__file__).resolve().parent
DOT_FILES = [
    ".ansible.cfg",
    ".black",
    ".bash_profile",
    ".bashrc",
    ".editorconfig",
    ".git-completion.bash",
    ".git-prompt.sh",
    ".gitconfig",
    ".gitignore",
    ".hgrc",
    ".hub.bash_completion.sh",
    ".ideavimrc",
    ".inputrc",
    ".ptconfig.toml",
    ".pythonstartup",
    ".tigrc",
    ".tmux.conf",
    ".vim",
]
CONFIG_DIRS = [".cache/tmp", ".config"]
CONFIG_ITEMS = ["ghostty"]  # .config/ 以下にリンクするファイル/ディレクトリ
CLAUDE_ITEMS = ["settings.json", "commands", "skills", "agents"]  # .claude/ 以下にリンクするファイル/ディレクトリ


def check_exists_path(fname):
    path = HOME_DIR / fname
    return path.exists() or path.is_symlink()


def put_symbolic_link(fname, parent_dir="", alias=""):
    msg = "Already exists file"
    dst = Path(parent_dir, alias if alias else fname)
    if not check_exists_path(dst):
        (HOME_DIR / dst).symlink_to(BASE_DIR / parent_dir / fname)
        msg = "Put Symbolic Link"
    print(msg + ": %s" % (alias if alias else fname))


def setup_dotfile(fname):
    if fname == ".bashrc" and check_exists_path(fname):
        put_symbolic_link(fname, alias=".bash_aliases")

    elif fname == ".vim":
        if sys.platform.startswith("win32"):
            put_symbolic_link(fname, alias="vimfiles")
        put_symbolic_link(fname)

    elif fname == ".gitconfig":
        put_symbolic_link(fname)
        if sys.platform.startswith("win32"):
            put_symbolic_link(".gitconfig.win", alias=".gitconfig.os")
        else:
            put_symbolic_link(".gitconfig.unix", alias=".gitconfig.os")

    else:
        put_symbolic_link(fname)


def prepare_dir(fpath):
    msg = "Already exists directory: %s" % fpath
    if not check_exists_path(fpath):
        (HOME_DIR / fpath).mkdir(parents=True, exist_ok=True)
        msg = "Put directory: %s" % fpath
    print(msg)


def setup_claude():
    """Claude Code 設定のセットアップ"""
    claude_dir = HOME_DIR / ".claude"

    # .claude ディレクトリが存在しない場合は作成
    if not claude_dir.exists():
        claude_dir.mkdir(parents=True, exist_ok=True)
        print("Created directory: .claude")

    # 各アイテムのリンク
    for item in CLAUDE_ITEMS:
        src = BASE_DIR / ".claude" / item
        dst = claude_dir / item

        if not src.exists():
            print(f"Source not found: .claude/{item}")
            continue

        if dst.exists() or dst.is_symlink():
            print(f"Already exists: .claude/{item}")
        else:
            dst.symlink_to(src)
            print(f"Put Symbolic Link: .claude/{item}")


def main():
    # setup directory for config
    for fpath in CONFIG_DIRS:
        prepare_dir(fpath)
    # setup dotfiles
    for fname in DOT_FILES:
        setup_dotfile(fname)
    # setup .config
    for item in CONFIG_ITEMS:
        put_symbolic_link(item, parent_dir=".config")
    # setup .claude
    setup_claude()


if __name__ == "__main__":
    main()
