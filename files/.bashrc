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

# Disable Ctrl+S
stty stop undef

# fzf setting
if [ -f ~/.fzf.bash ]; then
  # https://tottoto.net/fzf-history-on-bash/
  __fzf_history__() {
    if type tac > /dev/null 2>&1; then tac="tac"; else tac="tail -r"; fi
    shopt -u nocaseglob nocasematch
    echo $(HISTTIMEFORMAT= history | command $tac | sed -e 's/^ *[0-9]\{1,\}\*\{0,1\} *//' -e 's/ *$//' | awk '!a[$0]++' |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --sync -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd))
  }
  bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`__fzf_history__`\e\C-e\er\e^"'


  if type "ghq" > /dev/null 2>&1; then
    function fzf-repo() {
      cd $(ghq list --full-path | fzf)
    }
    alias frepo="fzf-repo"
  fi

  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
  source ~/.fzf.bash
fi

# local setting
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
