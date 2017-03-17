# general aliases
alias df="df -h"
alias du="du -c -h"
alias mkdir="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"
alias ll="ls -lA"
alias lx="ll -BX"   # sort by extension
alias lz="ll -rS"   # sort by size
alias lt="ll -rt"   # sort by date
alias l.="ll -d .*" # show only hidden files
alias cd="pushd > /dev/null"
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"
alias vi=vim
alias svi='sudo vi'
alias mnt="mount | column -t"
alias pwdgen="openssl rand -base64 30"
alias ports="netstat -tulanp" # quickly list all TCP/UDP port on the server
alias ping="ping -c 5" # stop after sending count ECHO_REQUEST packets
alias wget="wget -c" # can resume downloads
alias a="aria2c"

# always enable colored grep output
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# media file info
alias mediameta="mplayer -vo null -ao null -identify -frames 0 -v"

# Git
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gb='git branch'
alias gc='git checkout'
alias gf='git reflog'
alias gma='git commit -am'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'

# general functions
function mkdr () { mkdir "$@" && cd "$_"; }

# console calc
function =  () { echo "$*" | bc -l; }
function py () { python -c "print $*"; }

# file creation
# example: mkfile ~/tmp 10M
# also:
#   truncate -s 10G foo
#   fallocate -l 5G bar
function mkfile () {
    dd if=/dev/zero of="$1" count=1 bs=$2;
}

# user dependant
if [ $UID -ne 0 ]; then
    # normal user
	alias apt='sudo apt'
	alias reboot='sudo reboot'
	alias suspend='sudo suspend'
	alias poweroff='sudo poweroff'
fi

alias agi='apt install'
alias agr='apt remove'
alias agar='apt autoremove'
alias agu='apt update && apt upgrade'

alias acs='apt search'
alias aci='apt show'
