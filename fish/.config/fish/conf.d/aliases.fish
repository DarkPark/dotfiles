alias vi='vim'
alias df='df --human-readable --print-type'
alias du='du --bytes --total --summarize'
alias duh='du --human-readable'
alias dua='dua --format binary'
alias duai='dua interactive'
alias free='free --human --total'
alias mkdir='mkdir --parents --verbose'
alias env='/usr/bin/env | sort'

# https://github.com/eza-community/eza/blob/main/man/eza_colors.5.md
set --export EZA_COLORS "nb=37:nk=32:uR=31:gR=31:da=37"
# https://github.com/eza-community/eza/blob/main/man/eza.1.md
alias ls='eza'
alias ll='ls --long --all --bytes --group --extended --time=modified --time-style="+%Y.%m.%d %H:%M" --git --group-directories-first --color-scale --sort=name'
alias llse='ll --sort=extension'
alias llss='ll --sort=size'
alias llst='ll --sort=type'
alias llsc='ll --sort=created --time=created'
alias llsm='ll --sort=modified'
alias llof='ll --only-files'
alias llod='ll --only-dirs'
alias llt='ll --tree'
alias llt2='ll --tree --level=2'
alias llt3='ll --tree --level=3'
alias llt4='ll --tree --level=4'
alias llt5='ll --tree --level=5'

alias mnt='mount | column --table | sort --key 3,3'

# quickly list all TCP/UDP port on the server
alias ports='sudo ss -tulpan'

# generate something like this: bFfXd0QRkgzWFz3nXjDnsPS/AzJm1KymcdMqTaJ4e7H5fle5
alias pwdgen='openssl rand -base64 36'

alias myip='curl --silent "https://ipinfo.io" | jq'
alias weather='curl --silent "https://wttr.in/Odessa?M"'

# stop after sending count ECHO_REQUEST packets
alias ping='ping -c 5'

alias untar='tar -zxvf'

# port 8000 without parameters
# set 0 to use random port
alias serve='python3 -m http.server'

if fish_is_root_user
    alias dmesg='dmesg --ctime --show-delta'
    alias ag='apt-get'
else
    alias dmesg='sudo dmesg --ctime --show-delta'
    alias ag='sudo apt-get'
    alias reboot='sudo reboot'
    alias suspend='sudo suspend'
    alias poweroff='sudo poweroff'
end

# apt install/remove
alias agi='ag install'
alias agr='ag remove'
alias agp='ag purge'
alias agu='ag update && ag upgrade'
alias agc='ag changelog'
alias agar='ag autoremove'

# apt cache
alias ac='apt-cache'
alias acn='ac pkgnames'
alias acs='ac search'
alias acsn='ac search --names-only'
alias acd='ac depends'
alias acrd='ac rdepends'
alias aci='ac show'
alias acp='ac policy'

# git
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

# docker
alias d='docker'
alias dps='docker ps --all --size'
alias dpsf='docker ps --all --size --no-trunc'
alias dc='docker compose'
alias dct='docker compose top'
alias dcps='docker compose ps --all'
alias dcpsf='docker compose ps --all --no-trunc'
alias ds='docker system'
alias dsp='docker system prune'

# nodejs
alias drun='docker run --interactive --tty --rm --user (id -u "$USER"):(id -g "$USER") --volume "$PWD":/srv --workdir /srv --network=host'
alias dnode='drun node:lts-slim'
alias dnode-pull='docker pull node:lts-slim'
alias dnpm='dnode npm'
alias dnpx='dnode npx'
alias dzx='drun zx'

alias dnu='docker run -it --rm ghcr.io/nushell/nushell:latest-bookworm'
alias dnu-pull='docker pull ghcr.io/nushell/nushell:latest-bookworm'

# systemd
alias sc='systemctl'
alias scs='systemctl status'
alias scr='systemctl restart'
alias scu='systemctl --user'
alias scue='systemctl --user enable'
alias scud='systemctl --user disable'
alias scudr='systemctl --user daemon-reload'
alias ssc='sudo systemctl'
alias sscs='sudo systemctl status'
alias sscr='sudo systemctl restart'
alias ssce='sudo systemctl enable'
alias sscd='sudo systemctl disable'
alias sscdr='sudo systemctl daemon-reload'
alias jc='journalctl --quiet'
alias jcb='journalctl --boot'
alias jcd='sudo journalctl --dmesg'
alias jcu='journalctl --unit'
alias jcuu='journalctl --user-unit'
alias sjc='sudo journalctl'
alias sjcf='sudo journalctl --follow'
alias sjcu='sudo journalctl --unit'
alias sss='sudo systemctl suspend'

# http://termbin.com/
# echo "just testing!" | tb
alias tb="nc termbin.com 9999"

# https://github.com/sharkdp/fd
#alias fd='fd --hidden --no-ignore'
alias fdf='fd --type file'
alias fdd='fd --type directory'
alias fdl='fd --type symlink'
alias fdx='fd --type executable'
alias fde='fd --type empty'

# https://github.com/muesli/duf
alias duf="duf --only local,network,fuse"
alias dufa="duf --all"
alias dufl="duf --only local"
alias dufn="duf --only network"
alias duff="duf --only fuse"

# https://github.com/sharkdp/bat
alias cat="batcat"

# https://github.com/dandavison/delta
alias delta="delta --side-by-side"

# https://github.com/ekzhang/bore
# bore local 8000 --to bore.pub
alias bore="docker run -it --init --rm --network host ekzhang/bore"
alias bore-pull="docker pull ekzhang/bore"
