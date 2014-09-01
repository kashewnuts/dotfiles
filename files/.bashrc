export EDITOR=vim
alias vi='vim'

# Python
export PYTHONSTARTUP=~/.pythonstartup
export PIP_DOWNLOAD_CACHE=~/.pip/download_cache

### Virtualenvwrapper
if [ -f `which virtualenvwrapper.sh` ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source `which virtualenvwrapper.sh`
fi

# crontab
alias crontab='crontab -i'

# git-comletion.bash
source ~/.git-prompt.sh
source ~/.git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

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

    ;;
esac
