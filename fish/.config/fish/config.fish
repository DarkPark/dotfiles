# https://fishshell.com/docs/current/index.html#configuration
# https://fishshell.com/docs/current/language.html
# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg


# do nothing in login shell mode
if not status is-interactive
    exit
end

# disable welcome message
set -U fish_greeting

# "most" as manpager
set -x MANPAGER most

# alt+v and alt+e editor
set -x EDITOR vim
set -x VISUAL vim

# https://github.com/ajeetdsouza/zoxide#installation
zoxide init fish | source

# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
#set -gx STARSHIP_CONFIG "/etc/starship.toml"
starship init fish | source

# https://docs.atuin.sh/guide/installation/
# https://docs.atuin.sh/configuration/key-binding/#fish
# set -gx ATUIN_NOBIND "true"
atuin init fish | source

# overwrite defaults
#source ~/.config/fish/functions/system.fish

# integration with https://github.com/junegunn/fzf
#source ~/.config/fish/functions/fzf.fish
