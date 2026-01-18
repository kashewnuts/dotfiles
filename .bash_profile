#!/usr/bin/env bash
if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

case "$(uname -a)" in
  Darwin*arm64)  # M1 Mac
  BREW_PREFIX="/opt/homebrew"
  eval "$(${BREW_PREFIX}/bin/brew shellenv)"
  LOCAL_PATH="${BREW_PREFIX}/opt/node@22/bin:${LOCAL_PATH}"
  LOCAL_PATH="${BREW_PREFIX}/opt/curl/bin:${LOCAL_PATH}"
  LOCAL_PATH="${BREW_PREFIX}/bin:${LOCAL_PATH}"
  LOCAL_PATH="$HOME/.local/bin:${LOCAL_PATH}"
  export PATH="${LOCAL_PATH}:$PATH"
  export BASH_SILENCE_DEPRECATION_WARNING=1
  ;;

  Linux.*microsoft)  # WSL
  # Docker
  export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
  export PATH="$PATH:$HOME/.windows_commands/"
  ;;

  linux*)   # Linux
  export PATH=$HOME/.local/bin:$PATH
esac

# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.bash 2>/dev/null || :

# https://qiita.com/key-amb/items/ce39b0c85b30888e1e3b#%E9%87%8D%E8%A4%87%E3%82%92%E9%81%BF%E3%81%91%E3%81%9F%E3%81%84%E6%96%B9%E3%81%B8%E3%82%AA%E3%82%B9%E3%82%B9%E3%83%A1%E3%81%AE%E3%82%84%E3%82%8A%E6%96%B9
for _p in $(echo "$PATH" | tr ':' ' '); do
  case ":${_path}:" in
    *:"${_p}":* )
      ;;
    * )
      if [ "$_path" ]; then
        if [ "${_p:0:1}" = "/" ]; then  # for Windows 'Program Files'
          _path="$_path:$_p"
        else
          _path="$_path $_p"
        fi
      else
        _path=$_p
      fi
      ;;
  esac
done
PATH=$_path

unset _p
unset _path
