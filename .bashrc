#!/usr/bin/env bash
export EDITOR=vim
case "$OSTYPE" in
  darwin*)  # BSD (contains Mac)
  export LANG=ja_JP.UTF-8
  vim() { env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"; }
  export GIT_EDITOR='vim'
  alias vi='vim -Nu ~/.vim/minimal.vim'
  # alias vi='/usr/local/bin/vim -Nu ~/.vim/minimal.vim -c "set laststatus=0" -c "set ruler" -c "set nonumber"'
  alias gvim='vim -g'
  export PYTHONUSERBASE=~/.local
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
  if [ -f ~/.Xmodmap ];then
    xmodmap ~/.Xmodmap
  fi
  ;;
esac
alias la='ls -al'
alias ll='ls -l'
alias d='docker'
alias dcp='docker-compose'
alias g='git'
alias v='vim'

# crontab
alias crontab='crontab -i'

# git-completion.bash
# source ~/.git-prompt.sh
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
  __git_complete g __git_main  # Completion for aliases
fi
# export GIT_PS1_SHOWDIRTYSTATE=true
# export PS1='$ '
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\W\[\033[31m\]$(__git_ps1)\[\033[00m\]\$\n'
# export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\W\[\033[00m\]\$\n'
# hub
if [ -f ~/.hub.bash_completion.sh ]; then
  source ~/.hub.bash_completion.sh
fi

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
if [[ $- == *i* ]]; then # in interactive session
  bind 'set keyseq-timeout 1'
fi

# fzf setting
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash

  if type "ghq" > /dev/null 2>&1; then
    function fzf-repo() {
      cd "$(ghq list --full-path | fzf)" || exit
    }
    alias frepo="fzf-repo"
  fi

  export FZF_DEFAULT_COMMAND='find .'
  # if type "pt" > /dev/null 2>&1; then
  #   export FZF_DEFAULT_COMMAND='pt -g ""'
  # fi
  if type "rg" > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-require-git --glob "!.git/*"'
  fi
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

  # Avoid duplicate command
  __fzf_history__() {
    if type tac > /dev/null 2>&1; then tac="tac"; else tac="tail -r"; fi
    if type gsed > /dev/null 2>&1; then sed="gsed"; else sed="sed"; fi
    shopt -u nocaseglob nocasematch
    echo $(HISTTIMEFORMAT= history | command $tac | $sed -e 's/^ *[0-9]\{1,\}\*\{0,1\} *//' -e 's/ *$//' | awk '!a[$0]++' |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --sync -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd))
  }

  if [[ $- == *i* ]]; then # in interactive session
    bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`__fzf_history__`\e\C-e\er\e^"'
  fi

fi

# local setting
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi

# # tabtab source for serverless package
# # uninstall by removing these lines or running `tabtab uninstall serverless`
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# # tabtab source for sls package
# # uninstall by removing these lines or running `tabtab uninstall sls`
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# # tabtab source for slss package
# # uninstall by removing these lines or running `tabtab uninstall slss`
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash

if [ -f /usr/local/bin/terraform ]; then
  complete -C /usr/local/bin/terraform terraform
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# pipx
#if type "pipx" > /dev/null 2>&1; then
#  eval "$(register-python-argcomplete pipx)"
#fi
