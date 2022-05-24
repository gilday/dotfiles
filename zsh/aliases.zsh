# enable using aliases with 'sudo' e.g. 'sudo ll'
# http://askubuntu.com/a/22043
alias sudo='sudo '

alias treediff="rsync -rvnc --delete $1 $2"

alias ll="ls -Glah"
alias l='ls -CF'

# When I type "gits" I mistyped and meant "git s"
alias gits="git status"

alias http="python -m http.server"

alias tcpd8443="sudo tcpdump -s 0 -A -i lo0 'tcp port 8443 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"

# pbcopy for not-macos
if [[ "$OSTYPE" != darwin* ]]; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

if [[ "$OSTYPE" == darwin* ]]; then
  alias updatedb='/usr/libexec/locate.updatedb'
fi

function ancestor()
{
    (~/bin/ancestor.rb $1) && cd $(~/bin/ancestor.rb $1)
}

function decrypt() {
    if [ $# -lt 2 ]; then
        echo "usage: decrypt <in> <out>"
    else
        openssl aes-256-ecb -d -in $1 -out $2
    fi
}

function encrypt() {
    openssl aes-256-ecb -in $1 -out $2
}

# sets up an ssh tunnel for rdp
function rdp() {
    ssh -L 33890:localhost:3389 -N $1
}

# On iterm2, sends fireworks shooting off from the cursor. Good for testing iterm2 escape codes
function fireworks() {
    echo -e "\x1b]1337;RequestAttention=fireworks\a"
}
