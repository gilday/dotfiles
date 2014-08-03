#!/bin/sh
# OS specific support
cygwin=false;
mac=false;
ubuntu=false;
case "`uname`" in
    CYGWIN*) cygwin=true ;;
    Darwin*) mac=true ;;
    Ubuntu*) ubuntu=true
esac

# EDITOR
export EDITOR=vim

# GIT BASH
if $mac && [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
PS1="\W\$(__git_ps1) \$ "

# Java
if $mac ; then
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
    export ANDROID_HOME=/Applications/Android\ Studio.app/sdk
fi

if $ubuntu ; then
    export JAVA_HOME=/usr/lib/jvm/jdk1.7.0
    export ANDROID_HOME=/home/jgilday/devtools/android-sdk-linux
fi

if $cygwin ; then
    export JAVA_HOME="$HOME/devtools/java"
fi

export M2_HOME="$HOME/devtools/maven"
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=256m -Xss1024k"
export GRAILS_HOME="$HOME/devtools/grails/grails-1.3.7/bin"
export ANT_HOME="$HOME/devtools/ant" 
export GRADLE_HOME="$HOME/devtools/gradle"

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

# Load aliases from bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function ancestor()
{
    (~/dotfiles/ancestor.rb $1) && cd $(~/dotfiles/ancestor.rb $1)
}

function decrypt() {
    openssl des3 -d -in $1 -out $2
}

function encrypt() {
    openssl des3 -in $1 -out $2
}

# PATH
if $mac ; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/devtools/groovy/bin
PATH=$PATH:$GRAILS_HOME
PATH=$PATH:/usr/local/bin
PATH=$PATH:$HOME/devtools/jmeter/bin
PATH=$PATH:$HOME/devtools/sbt/bin
PATH=$PATH:$HOME/devtools/maven/bin
PATH=$PATH:$ANT_HOME/bin
PATH=$PATH:$JAVA_HOME/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$GRADLE_HOME/bin
PATH=$PATH:$MYSQL_HOME
PATH=$PATH:/usr/local/lib/node_modules/karma/bin

# RVM (should be last supposedly)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

