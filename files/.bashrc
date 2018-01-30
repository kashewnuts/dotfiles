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

  case "$OSTYPE" in
    darwin*)  # BSD (contains Mac)
    function peco-history() {
      local NUM=$(history | wc -l)
      local FIRST=$((-1*(NUM-1)))

      if [ $FIRST -eq 0 ] ; then
        # Remove the last entry, "peco-history"
        history -d $((HISTCMD-1))
        echo "No history" >&2
        return
      fi

      local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

      if [ -n "$CMD" ] ; then
        # Replace the last entry, "peco-history", with $CMD
        history -s $CMD

        if type osascript > /dev/null 2>&1 ; then
          # Send UP keystroke to console
          (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
        fi

        # Uncomment below to execute it here directly
        # echo $CMD >&2
        # eval $CMD
      else
        # Remove the last entry, "peco-history"
        history -d $((HISTCMD-1))
      fi
    }
    # bind -x '"\C-r": peco-history'
    ;;

    linux*)
    function peco-history() {
      local l=$(HISTTIMEFORMAT= history |  sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -e 's/^\s*[0-9]*\s*//' | perl -ne 'print unless $seen{$_}++' | peco --query "$READLINE_LINE")
      READLINE_LINE="$l"
      READLINE_POINT=${#l}
    }
  # function peco-history() {
  #   declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
  #   READLINE_LINE="$l"
  #   READLINE_POINT=${#l}
  # }
    bind -x '"\C-r": peco-history'
    ;;
  esac
fi

# local setting
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
