if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

case "$OSTYPE" in
  darwin*)  # BSD (contains Mac)
  # Setting PATH for Python 3.4〜3.7
  # The original version is saved in .bash_profile.pysave
  PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
  PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
  PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
  PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
  export PATH="$HOME/Library/Python/3.6/bin:$PATH"
  [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
  ;;

  linux*)   # Linux
  export PATH=$HOME/.local/bin/:$PATH
esac
eval "$(hub alias -s)"
