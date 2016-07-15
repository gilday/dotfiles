#!/bin/sh
# OS specific support
cygwin=false;
mac=false;
ubuntu=false;
centos=false;
case "`uname`" in
    CYGWIN*) cygwin=true ;;
    Darwin*) mac=true ;;
    Ubuntu*) ubuntu=true;;
    Linux*) centos=true;; # TODO need a better check for CentOS
esac

# EDITOR
export EDITOR=vim

# GIT BASH
if $mac && [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
if $centos && [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi
# if none of those sources worked, source the local copy in this repo
if [ ! $(command -v __git_ps1) ]; then
    source $HOME/dotfiles/git-prompt.sh
fi
PS1="\W\$(__git_ps1) \$ "

# Java
if $mac ; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export ANDROID_HOME=$HOME/devtools/android-sdk
fi

if $ubuntu ; then
    export JAVA_HOME=/usr/lib/jvm/jdk1.7.0
    export ANDROID_HOME=$HOME/devtools/android-sdk-linux
fi

if $cygwin ; then
    export JAVA_HOME="$HOME/devtools/java"
fi

export M2_HOME="$HOME/devtools/maven"
export M2_REPO="$HOME/.m2/repository"
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=256m -Xss1024k"
export GRAILS_HOME="$HOME/devtools/grails/grails-1.3.7/bin"
export ANT_HOME="$HOME/devtools/ant" 
export GRADLE_HOME="$HOME/devtools/gradle"
export JBOSS_HOME="$HOME/devtools/wildfly"
export GOPATH="$HOME/development/gopath"


if $cygwin ; then
# X11
    # define X11 display, if not already defined
    if [[ "$DISPLAY" == "" ]] ; then
        export DISPLAY=:0
    fi
# ssh
    # note: this requires keychain package
    # keychain is a daemon that will manage ssh-agent
    # it's cool because I don't have to re-enter the passphrase for every terminal
    if [ -e $HOME/.ssh/$USER ] ; then
        eval $(keychain --eval $HOME/.ssh/$USER)
    else
        eval $(keychain --eval $HOME/.ssh/id_rsa)
    fi
fi

# Predictable SSH authentication socket location
SOCK="/tmp/ssh-agent-${USER}"
if test ${SSH_AUTH_SOCK} && [ ${SSH_AUTH_SOCK} != ${SOCK} ]; then
    rm -f "/tmp/ssh-agent-${USER}"
    ln -sf ${SSH_AUTH_SOCK} ${SOCK}
    export SSH_AUTH_SOCK=${SOCK}
fi

# ansible on windows
if $cygwin ; then
    # do some manual steps from https://servercheck.in/blog/running-ansible-within-windows
    ANSIBLE=/opt/ansible
    export PATH=$PATH:$ANSIBLE/bin
    export PYTHONPATH=$ANSIBLE/lib
    export ANSIBLE_LIBRARY=$ANSIBLE/library
fi

# pbcopy
if $ubuntu ; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
elif $cygwin ; then
    alias pbcopy='cat >/dev/clipboard'
    alias pbpaste='cat /dev/clipboard'
fi

# BASH History
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# updatedb alias for mac
if $mac ; then
    alias updatedb='/usr/libexec/locate.updatedb'
fi

# Load aliases from bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function ancestor()
{
    (~/dotfiles/ancestor.rb $1) && cd $(~/dotfiles/ancestor.rb $1)
}

function decrypt() {
    if [ $# -lt 2 ]; then
        echo "usage: decrypt <in> <out>"
    else
        openssl des3 -d -in $1 -out $2
    fi
}

function encrypt() {
    openssl des3 -in $1 -out $2
}

# sets up an ssh tunnel for rdp
function rdp() {
    ssh -L 33890:localhost:3389 -N $1
}

# PATH
if $mac ; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/devtools/groovy/bin
PATH=$PATH:$GRAILS_HOME
PATH=$PATH:/usr/local/bin
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/devtools/jmeter/bin
PATH=$PATH:$HOME/devtools/sbt/bin
PATH=$PATH:$HOME/devtools/maven/bin
PATH=$PATH:$HOME/devtools/phantomjs/bin
PATH=$PATH:$ANT_HOME/bin
PATH=$PATH:$JAVA_HOME/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$GRADLE_HOME/bin
PATH=$PATH:$MYSQL_HOME
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$GOPATH/bin
PATH=$PATH:$HOME/.npm-global/bin

# Source extra bashrc_hook file if it exists. Do not check this file into
# version control - it is for extra, environment specific stuff
if [ -f ~/.bashrc_hook ]; then
    source ~/.bashrc_hook
fi

# RVM (should be last supposedly)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi
