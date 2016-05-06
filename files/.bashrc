export EDITOR=vim

alias la='ls -al'
alias ll='ls -l'

if [ "$OSTYPE" != 'msys' ]; then
    alias vi='vim'

    # Python
    export PYTHONSTARTUP=~/.pythonstartup
    export PIP_DOWNLOAD_CACHE=~/.pip/download_cache

    # Virtualenvwrapper
    if [ -f virtualenvwrapper.sh ]; then
        export WORKON_HOME=$HOME/.virtualenvs
        source virtualenvwrapper.sh
    fi

    # crontab
    alias crontab='crontab -i'

    # git-comletion.bash
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=true
    export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

    # Golang
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/project/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
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
    alias vi='winpty /c/Application/vim/vi.exe'
    alias vim='/c/Application/vim/vim.exe'
    alias vagrant='/c/HashiCorp/Vagrant/bin/vagrant.exe'
    ;;
esac

# local setting
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
