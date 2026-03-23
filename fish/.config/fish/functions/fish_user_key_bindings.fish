function _list_dir
    echo
    ll
    commandline --function repaint
end

function _goto_parent_dir
    cd ..
    commandline --function repaint
end

# https://fishshell.com/docs/current/cmds/bind.html
# https://fishshell.com/docs/current/cmds/fish_key_reader.html
# https://man7.org/linux/man-pages/man3/readline.3.html
# https://en.wikipedia.org/wiki/ANSI_escape_code
# to detect key codes:
# fish_key_reader
# sed -n l
function fish_user_key_bindings
    # https://atuin.sh/docs/key-binding#fish
    # bind to ctrl-r in normal and insert mode
    bind \cr _atuin_search
    bind -M insert \cr _atuin_search

    #bind \cV _fzf_search_vars_command

    # ctrl+f
    bind \cf _fzf_select_file
    # alt+f
    bind \ef _fzf_select_dir
    # bind \cf _fzf_search_directory

    # ctrl+alt+down
    bind \e\[1\;7B _fzf_zoxide_cd

    # alt+c
    bind \ec _fzf_cd

    # # ctrl+alt+up
    bind \e\[1\;7A _goto_parent_dir

    # # ctrl+alt+right
    # bind \e\[1\;7C _list_dir

    # ctrl+del
    bind \e\[3\;5~ kill-word
    # alt+del
    bind \e\[3\;3~ kill-bigword

    # ctrl+up
    bind \e\[1\;5A history-prefix-search-backward
    # ctrl+down
    bind \e\[1\;5B history-prefix-search-forward

    # ctrl+backspace
    bind \b backward-kill-word
    # alt+backspace
    bind \e\x7F backward-kill-bigword

    # ctrl+home
    bind \e\[1\;5H beginning-of-buffer
    # ctrl+end
    bind \e\[1\;5F end-of-buffer

    # alt+k
    bind \ek kill-whole-line

    # shift+alt+u
    bind \eU downcase-word

    # bind \e, begin-selection
    # bind \e. end-selection
end
