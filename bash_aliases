alias android-connect="mtpfs -o allow_other /media/GalaxyNexus"
alias android-disconnect="fusermount -u /media/GalaxyNexus"

alias treediff="rsync -rvnc --delete $1 $2"

alias mvnci="mvn clean install"

alias ll="ls -lah"
alias l='ls -CF'

# When I type "gits" I mistyped and meant "git s"
alias gits="git status"

alias http="python -m SimpleHTTPServer"

alias tcpd8443="sudo tcpdump -s 0 -A -i lo0 'tcp port 8443 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"

