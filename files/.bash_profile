if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

case "$OSTYPE" in
    # BSD (contains Mac)
    darwin*)

    # Setting PATH for Python 2.7
    # The orginal version is saved in .bash_profile.pysave
    PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
    export PATH

    ;;
esac
