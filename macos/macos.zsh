path+=/Applications/kdiff3.app/Contents/MacOS
path+=/usr/local/opt/coreutils/libexec/gnubin
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Only check for Homebrew updates once every 5 days
export HOMEBREW_AUTO_UPDATE_SECS=432000

# Copy path to launcher
launchctl setenv PATH $PATH
