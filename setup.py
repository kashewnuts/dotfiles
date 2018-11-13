#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DOT_FILES_DIR = os.path.join(BASE_DIR, 'files')
DOT_FILES = [
    '.ansible.cfg',
    '.bash_profile',
    '.bashrc',
    '.git-completion.bash',
    '.git-prompt.sh',
    '.gitconfig',
    '.gitconfig.unix',
    '.gitignore',
    '.hgrc',
    '.ideavimrc',
    '.inputrc',
    '.isort.cfg',
    '.ptconfig.toml',
    '.pythonstartup',
    '.tigrc',
    '.tmux.conf',
    '.tmux.conf.osx',
    '.vim',
]
PATH_LIST = ['~/.cache/tmp', '~/.config']
CONFIG_FILES = ['pep8', 'flake8']


def check_exists_path(path):
    p = os.path.join(os.path.expanduser('~'), path)
    return os.path.exists(p)


def put_symbolic_link(path, parent_dir='', alias=''):
    p = os.path.join(os.path.expanduser('~'), parent_dir, alias if alias else path)
    msg = 'Already exists file'
    if not check_exists_path(p):
        os.symlink(os.path.join(DOT_FILES_DIR, parent_dir, path), p)
        msg = 'Put Symbolic Link'
    print(msg + ': %s' % (alias if alias else path))


def setup_dotfiles(path):
    if path == '.bashrc' and check_exists_path(path):
        put_symbolic_link(path, alias='.bash_aliases')

    elif path == '.vim':
        if sys.platform.startswith('win32'):
            put_symbolic_link(path, alias='vimfiles')
        put_symbolic_link(path)

    elif path == '.gitconfig.unix':
        p = '.gitconfig.win' if sys.platform.startswith('win32') else path
        put_symbolic_link(p, alias='.gitconfig.os')

    elif path == '.tmux.conf.osx':
        if sys.platform.startswith('darwin'):
            put_symbolic_link(path)

    else:
        put_symbolic_link(path)


def prepare_dir():
    for path in PATH_LIST:
        p = os.path.expanduser(path)
        if not check_exists_path(p):
            os.makedirs(p)


def main():
    # setup dotfiles
    for path in DOT_FILES:
        setup_dotfiles(path)

    # setup .config
    prepare_dir()
    for path in CONFIG_FILES:
        put_symbolic_link(path, parent_dir='.config')


if __name__ == "__main__":
    main()
