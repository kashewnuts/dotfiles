if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi

# MacPorts Installer addition on 2012-04-22_at_16:20:04: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH:
# Finished adapting your PATH environment variable for use with MacPorts.
