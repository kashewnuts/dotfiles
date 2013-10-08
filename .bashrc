case "$OSTYPE" in
    # BSD (contains Mac)
    darwin*)
    # Editor
    export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
    alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias mvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'
    export VIM=/Applications/MacVim.app/Contents/Resources/vim
    export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime

    # Open
    alias firefox="open -a Firefox"
    alias safari="open -a Safari"
    alias preview="open -a preview"

    # Virtualenv
    export PATH=/opt/local/bin:$PATH;
    export PATH=$PATH:/usr/local/mysql/bin
    export VIRTUALENV_USE_DISTRIBUTE=true
    export VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python
    export VIRTUALENVWRAPPER_VIRTUALENV=/opt/local/bin/virtualenv
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    source /opt/local/bin/virtualenvwrapper.sh

    # Django
    . ~/.django_bash_completion

    # nvm
    source ~/.nvm/nvm.sh
    alias nvmu='nvm use "v0.8.21"'
    ;;
esac

export PS1='\h:\w\$ '
export PS2=''
export EDITOR=vi
alias ls='ls -FN'
alias vi='vim'

# Python
export PYTHONSTARTUP=~/.pythonstartup
export PIP_DOWNLOAD_CACHE=~/.pip/download_cache

# crontab
alias crontab='crontab -i'
