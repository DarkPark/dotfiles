function fixssh
    set -l socket (tmux show-environment SSH_AUTH_SOCK 2>/dev/null | string replace 'SSH_AUTH_SOCK=' '')

    if test -S "$socket"
        set -gx SSH_AUTH_SOCK "$socket"
    end
end
