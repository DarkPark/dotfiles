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
alias ..="cd .."
alias mnt="mount | column -t"
alias pwdgen="openssl rand -base64 30"
alias ports="netstat -tulanp" # quickly list all TCP/UDP port on the server
alias ping="ping -c 5" # stop after sending count ECHO_REQUEST packets
alias wget="wget -c" # can resume downloads
alias a="aria2c"

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
function mkfile () { dd if=/dev/zero of="$1" count=1 bs=$2; }

# user dependant
if [ $UID -ne 0 ];
then # normal user
	alias apt='sudo apt'
	alias reboot='sudo reboot'
	alias poweroff='sudo poweroff'
fi

alias agi='apt install'
alias agr='apt remove'
alias agar='apt autoremove'
alias agu='apt update && apt upgrade'
	
alias acs='apt search'
alias aci='apt show'


# prompt type depends on shell mode
if shopt -q login_shell; then
	# login shell
	PROMPT_COMMAND='history -a; history -n'
else
	# not login shell
	PROMPT_COMMAND='history -a; history -n; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
fi

# no limits
export HISTSIZE=-1
export HISTFILESIZE=-1

#export HISTTIMEFORMAT="%Y.%m.%d %H:%M:%S :: "
#export GREP_OPTIONS="--color=auto"

# prompt colors
BG_RED='\[\e[41m\]'
COLOR_TIME='\[\e[1;30m\]'
COLOR_PATH='\[\e[00;36m\]'
COLOR_RESET='\[\e[0m\]'

# prompt title
if [ $UID -eq 0 ];
then # you are root, set red colour prompt
	COLOR_USER='\[\e[00;31m\]'
	COLOR_HOST='\[\e[01;31m\]'
	PS1="${debian_chroot:+($debian_chroot)}${COLOR_TIME}\$([[ \$? != 0 ]] && echo '${COLOR_RESET}${BG_RED}')\t${COLOR_RESET} ${COLOR_USER}\u${COLOR_RESET}@${COLOR_HOST}\H ${COLOR_PATH}\w ${COLOR_USER}# ${COLOR_RESET}"
else # normal
	COLOR_USER='\[\e[00;32m\]'
	COLOR_HOST='\[\e[01;32m\]'
	PS1="${debian_chroot:+($debian_chroot)}${COLOR_TIME}\$([[ \$? != 0 ]] && echo '${COLOR_RESET}${BG_RED}')\t${COLOR_RESET} ${COLOR_USER}\u${COLOR_RESET}@${COLOR_HOST}\H ${COLOR_PATH}\w ${COLOR_USER}$ ${COLOR_RESET}"
fi

# autojump - a faster way to navigate your file system
#. /usr/share/autojump/autojump.bash

# enables tab-completion in all npm commands
#source <(npm completion)
