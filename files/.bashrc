export EDITOR=vim

alias ls='ls --show-control-chars'
alias la='ls -al'
alias ll='ls -l'

if [ "$OSTYPE" != 'msys' ]; then
    # alias vi='vim'
    alias vi='vim -Nu ~/.vim/rc/minimal.vim'

    # Python
    export PYTHONSTARTUP=~/.pythonstartup
    export PIP_DOWNLOAD_CACHE=~/.pip/download_cache
    export PYTHONPATH=~/pycharm-debug.egg:~/pycharm-debug-py3k.egg:$PYTHONPATH

    # Virtualenvwrapper
    export WORKON_HOME=~/.venvs
    export VIRTUALENV_PYTHON=/usr/bin/python3
    # export BROWSER=echo heroku open

    # crontab
    alias crontab='crontab -i'

    # git-comletion.bash
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=true
    export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

    # Golang
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOPATH/bin

    # Jupyter Notebook
    alias iPythonNotebook='cd ~/project/ipythondir;jupyter notebook'
fi

case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
    # Editor
    export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'

    # Open
    alias firefox="open -a Firefox"
    alias safari="open -a Safari"
    alias preview="open -a preview"
    ;;

# MSYS
msys*)
    alias vi='TERM=xterm-256color /usr/bin/vim.exe'
    alias vim='/c/Application/vim/vim.exe'
    alias vagrant='/c/HashiCorp/Vagrant/bin/vagrant.exe'
    alias python='winpty python.exe'
    ;;
esac

# local setting
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
