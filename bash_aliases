# bash_aliases

# enable using aliases with 'sudo' e.g. 'sudo ll'
# http://askubuntu.com/a/22043
alias sudo='sudo '

alias android-connect="mtpfs -o allow_other /media/GalaxyNexus"
alias android-disconnect="fusermount -u /media/GalaxyNexus"

alias treediff="rsync -rvnc --delete $1 $2"

alias mvnci="mvn clean install"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll="ls -Glah"
alias l='ls -CF'

# When I type "gits" I mistyped and meant "git s"
alias gits="git status"

alias http="python -m SimpleHTTPServer"

alias tcpd8443="sudo tcpdump -s 0 -A -i lo0 'tcp port 8443 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"

# rebase current branch with the latest from the main line of development (develop at Contrast)
alias gitrebase="git checkout develop && git pull && git checkout - && git rebase develop"
