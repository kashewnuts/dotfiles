if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

case "$OSTYPE" in
  darwin*)  # BSD (contains Mac)
  # Setting PATH for Python 3.4〜3.7
  # The original version is saved in .bash_profile.pysave
  # PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
  # PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
  LOCAL_PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
  LOCAL_PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${LOCAL_PATH}"
  LOCAL_PATH="$HOME/.local/bin:${LOCAL_PATH}"
  LOCAL_PATH="/usr/local/opt/imagemagick@6/bin:${LOCAL_PATH}"
  export PATH="${LOCAL_PATH}"
  export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/opt/imagemagick@6/lib/
  ;;

  linux*)   # Linux
  export PATH=$HOME/.local/bin:$PATH
esac

# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# https://qiita.com/key-amb/items/ce39b0c85b30888e1e3b#%E9%87%8D%E8%A4%87%E3%82%92%E9%81%BF%E3%81%91%E3%81%9F%E3%81%84%E6%96%B9%E3%81%B8%E3%82%AA%E3%82%B9%E3%82%B9%E3%83%A1%E3%81%AE%E3%82%84%E3%82%8A%E6%96%B9
_path=""
for _p in $(echo $PATH | tr ':' ' '); do
  case ":${_path}:" in
    *:"${_p}":* )
      ;;
    * )
      if [ "$_path" ]; then
        _path="$_path:$_p"
      else
        _path=$_p
      fi
      ;;
  esac
done
PATH=$_path

unset _p
unset _path

