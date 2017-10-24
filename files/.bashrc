export EDITOR=vim

if [[ "$OSTYPE" =~ ^linux$ ]]; then
    export LANGUAGE=ja_JP:ja
    alias ls='ls --show-control-chars'
fi
alias la='ls -al'
alias ll='ls -l'

if [ "$OSTYPE" != 'msys' ]; then
    # Python
    export PYTHONSTARTUP=~/.pythonstartup
    export PIP_DOWNLOAD_CACHE=~/.pip/download_cache

    # Virtualenvwrapper
    export VIRTUALENV_PYTHON=`which python3`
    export VIRTUALENVWRAPPER_PYTHON=`which python3`
    if [ -f `which virtualenvwrapper.sh` ]; then
        source `which virtualenvwrapper.sh`
    fi
    # export BROWSER=echo heroku open

    # crontab
    alias crontab='crontab -i'

    # git-comletion.bash
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=true
    export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$\n'

    # Golang
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOPATH/bin

    # Jupyter Notebook
    alias iPythonNotebook='cd ~/project/ipythondir;jupyter notebook'
    # disable pyc
    export PYTHONDONTWRITEBYTECODE=1

    # bash
    export HISTSIZE=1000
    export HISTCONTROL=ignoreboth   # ignorespace+ignoredups = ignoreboth
    export HISTIGNORE="ls:fg*:history*"
fi

case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
    # Editor
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim=vi
    alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'

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
