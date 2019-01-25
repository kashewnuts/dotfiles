#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys

HOME_DIR = os.path.expanduser('~')
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
CONFIG_DIRS = ['.cache/tmp', '.config']
CONFIG_FILES = ['pep8', 'flake8', 'pycodestyle']


def check_exists_path(fname):
    fpath = os.path.join(HOME_DIR, fname)
    return os.path.exists(fpath)


def put_symbolic_link(fname, parent_dir='', alias=''):
    dst = os.path.join(parent_dir, alias if alias else fname)
    msg = 'Already exists file'
    if not check_exists_path(dst):
        os.symlink(os.path.join(DOT_FILES_DIR, parent_dir, fname),
                   os.path.join(HOME_DIR, dst))
        msg = 'Put Symbolic Link'
    print(msg + ': %s' % (alias if alias else fname))


def setup_dotfile(fname):
    if fname == '.bashrc' and check_exists_path(fname):
        put_symbolic_link(fname, alias='.bash_aliases')

    elif fname == '.vim':
        if sys.platform.startswith('win32'):
            put_symbolic_link(fname, alias='vimfiles')
        put_symbolic_link(fname)

    elif fname == '.gitconfig.unix':
        src = '.gitconfig.win' if sys.platform.startswith('win32') else fname
        put_symbolic_link(src, alias='.gitconfig.os')

    elif fname == '.tmux.conf.osx':
        if sys.platform.startswith('darwin'):
            put_symbolic_link(fname)

    else:
        put_symbolic_link(fname)


def prepare_dir(fpath):
    msg = 'Already exists directory: %s' % fpath
    if not check_exists_path(fpath):
        os.makedirs(os.path.join(HOME_DIR, fpath))
        msg = 'Put directory: %s' % fpath
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
        put_symbolic_link(fname, parent_dir='.config')


if __name__ == "__main__":
    main()
