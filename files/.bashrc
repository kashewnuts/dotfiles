#!/bin/bash
export EDITOR=vim
case "$OSTYPE" in
  darwin*)  # BSD (contains Mac)
  export GIT_EDITOR='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
  if [ -n "${DEMO}" ] && [ "${DEMO}" = "1" ]; then
    export PS1='\[\033[00m\]\$ '
    vim() { env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -c "set laststatus=0 set ruler set nonumber" "$@"; }
    alias vi=vim
  else
    vim() { env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"; }
    alias vi='vim -Nu ~/.vim/minimal.vim'
  fi
  alias gvim='vim -g'
  [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
  ;;

  msys*)    # MSYS
  alias vi='TERM=xterm-256color /usr/bin/vim.exe'
  alias vim='/c/Application/vim/vim.exe'
  alias vagrant='/c/HashiCorp/Vagrant/bin/vagrant.exe'
  alias python='winpty python.exe'
  ;;

  linux*)   # Linux
  export LANGUAGE=ja_JP:ja
  alias vi='vim -Nu ~/.vim/minimal.vim'
  alias ls='ls --show-control-chars'
  alias open='xdg-open &>/dev/null'
esac
alias la='ls -al'
alias ll='ls -l'

# crontab
alias crontab='crontab -i'

# git-comletion.bash
source ~/.git-prompt.sh
source ~/.git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\W\[\033[31m\]$(__git_ps1)\[\033[00m\]\$\n'

# Python
export PYTHONDONTWRITEBYTECODE=1    # disable pyc
export PYTHONSTARTUP=~/.pythonstartup
export WORKON_HOME=~/.virtualenvs
export PIPENV_VENV_IN_PROJECT=true

# history
export HISTSIZE=10000
export HISTCONTROL=ignoreboth:erasedups # ignorespace+ignoredups = ignoreboth
export HISTIGNORE="ls:fg*:history*"
export HISTTIMEFORMAT=history | sort -nr | sort -uk2 | sort -n |

# Disable Ctrl+S
[ -t 0 ] && stty stop undef  # Check STDIN standard input

# Setting timeout for ESC
[ -t 0 ] && stty time 0  # Check STDIN standard input
bind 'set keyseq-timeout 1'

# fzf setting
if [ -f ~/.fzf.bash ]; then
  if type "ghq" > /dev/null 2>&1; then
    function fzf-repo() {
      cd "$(ghq list --full-path | fzf)" || exit
    }
    alias frepo="fzf-repo"
  fi

  if type "pt" > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='pt -g ""'
  fi

  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

_pipenv_completion() {
    local IFS=$'\t'
    COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _PIPENV_COMPLETE=complete-bash $1 ) )
    return 0
}

complete -F _pipenv_completion -o default pipenv

# local setting
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
