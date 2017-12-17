if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

# Load RVM into a shell session *as a function*
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [ "$OSTYPE" == 'darwin' ]; then
  # Setting PATH for Python 3.5
  # The original version is saved in .bash_profile.pysave
  PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/3.5/bin"
  export PATH
  test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi
