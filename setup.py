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
CONFIG_FILES = ["flake8", "mypy"]


def check_exists_path(fname):
    return (HOME_DIR / fname).exists()


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

    elif fname == ".tmux.conf":
        put_symbolic_link(fname)
        put_symbolic_link(".tmux.conf.osx")
        put_symbolic_link(".tmux.conf.linux")
        put_symbolic_link(".tmux.conf.wsl")

    else:
        put_symbolic_link(fname)


def prepare_dir(fpath):
    msg = "Already exists directory: %s" % fpath
    if not check_exists_path(fpath):
        (HOME_DIR / fpath).mkdir(parents=True, exist_ok=True)
        msg = "Put directory: %s" % fpath
    print(msg)


def main():
    # setup directory for config
    for fpath in CONFIG_DIRS:
        prepare_dir(fpath)
    # setup dotfiles
    for fname in DOT_FILES:
        setup_dotfile(fname)
    # setup .config
    for fname in CONFIG_FILES:
        put_symbolic_link(fname, parent_dir=".config")


if __name__ == "__main__":
    main()
