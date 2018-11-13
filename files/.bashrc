export EDITOR=vim
case "$OSTYPE" in
  darwin*)  # BSD (contains Mac)
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias vim=vi
  alias gvim='vi -g'
  export GIT_EDITOR='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
  ;;

  msys*)    # MSYS
  alias vi='TERM=xterm-256color /usr/bin/vim.exe'
  alias vim='/c/Application/vim/vim.exe'
  alias vagrant='/c/HashiCorp/Vagrant/bin/vagrant.exe'
  alias python='winpty python.exe'
  ;;

  linux*)   # Linux
  export LANGUAGE=ja_JP:ja
  alias ls='ls --show-control-chars'
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

# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# history
export HISTSIZE=10000
export HISTCONTROL=ignoreboth:erasedups # ignorespace+ignoredups = ignoreboth
export HISTIGNORE="ls:fg*:history*"

# Disable Ctrl+S
stty stop undef

# Setting timeout for ESC
stty time 0
bind 'set keyseq-timeout 1'

# fzf setting
if [ -f ~/.fzf.bash ]; then
  if type "ghq" > /dev/null 2>&1; then
    function fzf-repo() {
      cd $(ghq list --full-path | fzf)
    }
    alias frepo="fzf-repo"
  fi

  if type "pt" > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='pt -g ""'
  fi

  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
  export FZF_UNIQUE_HISTORY=1   # https://github.com/junegunn/fzf/pull/1363/files
  source ~/.fzf.bash
fi

# For DEMO
if [ -n "${DEMO}" ] && [ "${DEMO}" = "1" ]; then
  export PS1='\[\033[00m\]\$ '
  case "$OSTYPE" in
    darwin*)  # BSD (contains Mac)
      alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -c "set laststatus=0" -c "set ruler" -c "set nonumber" "$@"'
      alias vim=vi
      alias gvim='vi -g'
    ;;
  esac
fi

# local setting
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
