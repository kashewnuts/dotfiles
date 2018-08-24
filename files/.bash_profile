if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

# Load RVM into a shell session *as a function*
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [[ $OSTYPE == "darwin"* ]]; then
    # Setting PATH for Python 3.6, 3.7
    # The original version is saved in .bash_profile.pysave
    PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
    PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
    export PATH
fi
