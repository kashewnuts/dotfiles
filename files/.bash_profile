#!/bin/bash
if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

case "$OSTYPE" in
  darwin*)  # BSD (contains Mac)
  LOCAL_PATH="/usr/local/opt/imagemagick@6/bin:${LOCAL_PATH}"
  LOCAL_PATH="/usr/local/opt/node@10/bin:${LOCAL_PATH}"
  LOCAL_PATH="$HOME/.local/bin:${LOCAL_PATH}"
  LOCAL_PATH="/usr/local/sbin:${LOCAL_PATH}"
  export PATH="${LOCAL_PATH}:${PATH}"
  export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/opt/imagemagick@6/lib/
  export BASH_SILENCE_DEPRECATION_WARNING=1

  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
  ;;

  linux*)   # Linux
  export PATH=$HOME/.local/bin:$PATH
  if uname -a | grep -q 'Linux.*microsoft'; then  # WSL
    # Docker
    export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
  fi
esac

# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

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
