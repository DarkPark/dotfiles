set -g fzf_color 'bg:-1,bg+:-1,fg:white,fg+:blue,hl:3,hl+:3,marker:red,pointer:red,gutter:-1,query:3,info:magenta,header:grey,prompt:grey,border:grey,label:grey'

set -x FZF_DEFAULT_OPTS "\
--exact \
--height=20% \
--layout=reverse \
--prompt='[ ' \
--info=inline:'] ' \
--separator='-' \
--pointer='▶' --marker='>' \
--border=none \
--color='$fzf_color'"

set -g fzf_common_arguments \
    --tabstop=4 \
    --preview-window 'right,50%,border' \
    --preview-label-pos=top

set -g fzf_dirs_arguments \
    --preview 'll --color=always {}' \
    --bind 'ctrl-p:toggle-preview' \
    --bind 'ctrl-s:change-preview(stat {})' \
    --bind 'ctrl-t:change-preview(tree -C --dirsfirst {})' \
    --bind 'ctrl-l:change-preview(ll --color=always {})' \
    --preview-label='[ Ctrl+P toggle preview, Ctrl+S stat, Ctrl+T tree, Ctrl+L list ]'

set -g fzf_files_arguments \
    --preview 'batcat --color=always --style=numbers {}' \
    --bind 'ctrl-p:toggle-preview' \
    --bind 'ctrl-s:change-preview(stat {})' \
    --bind 'ctrl-b:change-preview(batcat --color=always --style=numbers {})' \
    --preview-label='[ Ctrl+P toggle preview, Ctrl+S stat, Ctrl+B content ]'


function _fzf_get_token
    # get current user input
    set -l token (commandline --current-process --current-token)
    # expand any variables or leading tilde (~) in the token
    set -f expanded_token (eval echo -- $token)
    # unescape token because it's already quoted so backslashes will mess up the path
    set -f unescaped_exp_token (string unescape -- $expanded_token)

    echo $unescaped_exp_token
end


function _fzf_zoxide_cd
    set -l token (commandline --current-process --current-token)
    set -l fzf_local_arguments --no-sort --query="$token"
    set -l result (zoxide query --list 2>/dev/null | fzf $fzf_common_arguments $fzf_dirs_arguments $fzf_local_arguments)

    if test -n "$result"
        cd $result
        commandline --function repaint
    end
end


function _fzf_cd
    set -l token (_fzf_get_token)
    set -l fd_cmd fd --type directory
    set -l fzf_local_arguments

    # if the current token is a directory and has a trailing slash, then use it as fd's base directory
    if string match --quiet -- "*/" $token && test -d "$token"
        set --append fd_cmd --base-directory=$token --absolute-path
    else
        set --append fzf_local_arguments --query="$token"
    end

    set -f result ($fd_cmd 2>/dev/null | fzf $fzf_common_arguments $fzf_dirs_arguments $fzf_local_arguments)

    if test $status -eq 0
        cd $result
    end

    commandline --function repaint
end


function _fzf_select_file
    set -l token (_fzf_get_token)
    set -l fd_cmd fd --color=always --type file
    set -l fzf_local_arguments --ansi --multi

    # if the current token is a directory and has a trailing slash, then use it as fd's base directory
    if string match --quiet -- "*/" $token && test -d "$token"
        set --append fd_cmd --base-directory=$token --absolute-path
    else
        set --append fzf_local_arguments --query="$token"
    end

    set -f result ($fd_cmd 2>/dev/null | fzf $fzf_common_arguments $fzf_files_arguments $fzf_local_arguments)

    if test $status -eq 0
        commandline --current-token --replace -- (string escape -- $result | string join ' ')
    end

    commandline --function repaint
end


function _fzf_select_dir
    set -l token (_fzf_get_token)
    set -l fd_cmd fd --type directory
    set -l fzf_local_arguments --multi

    # if the current token is a directory and has a trailing slash, then use it as fd's base directory
    if string match --quiet -- "*/" $token && test -d "$token"
        set --append fd_cmd --base-directory=$token --absolute-path
    else
        set --append fzf_local_arguments --query="$token"
    end

    set -f result ($fd_cmd 2>/dev/null | fzf $fzf_common_arguments $fzf_dirs_arguments $fzf_local_arguments)

    if test $status -eq 0
        commandline --current-token --replace -- (string escape -- $result | string join ' ')
    end

    commandline --function repaint
end
