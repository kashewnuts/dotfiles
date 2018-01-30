export EDITOR=vim
case "$OSTYPE" in
  darwin*)  # BSD (contains Mac)
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias vim=vi
  alias gvim='vi -g'
  ;;

  msys*)    # MSYS
  alias vi='TERM=xterm-256color /usr/bin/vim.exe'
  alias vim='/c/Application/vim/vim.exe'
  ;;
esac

if [[ "$OSTYPE" =~ ^linux$ ]]; then
  export LANGUAGE=ja_JP:ja
  alias ls='ls --show-control-chars'
fi
alias la='ls -al'
alias ll='ls -l'

# crontab
alias crontab='crontab -i'

# git-comletion.bash
source ~/.git-prompt.sh
source ~/.git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\W\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# Python
export PYTHONDONTWRITEBYTECODE=1    # disable pyc
export PYTHONSTARTUP=~/.pythonstartup
export WORKON_HOME=~/.virtualenvs
export PIPENV_VENV_IN_PROJECT=true

# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# history
export HISTSIZE=10000
export HISTCONTROL=ignoreboth   # ignorespace+ignoredups = ignoreboth
export HISTIGNORE="ls:fg*:history*"

if [ "$OSTYPE" == 'msys' ]; then
  alias vagrant='/c/HashiCorp/Vagrant/bin/vagrant.exe'
  alias python='winpty python.exe'
fi

if type "peco" > /dev/null 2>&1; then
  function _peco-cd() {
    ([ -z "$2" ] && [ ! -z "$1" ]) && cd "$1" || cd "$2"
  }
  if type "ghq" > /dev/null 2>&1; then
    function peco-repo() {
      _peco-cd $(ghq list --full-path | peco --query "$LBUFFER")
    }
    # bind -x '"\C-]": peco-repo'
    alias prepo="peco-repo"
  fi

  function peco-cd() {
    _peco-cd $(find . -maxdepth 3 -type d | sed -e 's;\./;;' | peco)
  }
  alias pcd="peco-cd"

  function peco-history() {
    local l=$(HISTTIMEFORMAT= history | sed -e 's/^\s*[0-9]*\s*//' | perl -ne 'print unless $seen{$_}++' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
  }
  bind -x '"\C-r": peco-history'
fi

# local setting
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
