export EDITOR=vim
alias vi='vim'

# Python
export PYTHONSTARTUP=~/.pythonstartup
export PIP_DOWNLOAD_CACHE=~/.pip/download_cache

# crontab
alias crontab='crontab -i'

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
