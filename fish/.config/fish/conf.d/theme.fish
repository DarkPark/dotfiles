# https://fishshell.com/docs/current/cmds/set_color.html
# https://fishshell.com/docs/current/interactive.html#syntax-highlighting-variables


# default color
set fish_color_normal normal

# commands like `echo`
set fish_color_command green --bold

# keywords like if - this falls back on the command color if unset
set fish_color_keyword green

# quoted text like "abc"
set fish_color_quote yellow

# IO redirection like > /dev/null
set fish_color_redirection red

# process separators like ; and &
set fish_color_end magenta

# syntax errors
set fish_color_error red --bold

# ordinary command parameters
set fish_color_param normal

# parameters that are filenames (if the file exists)
set fish_color_valid_path brblue

# options starting with "-", up to the first "--" parameter
set fish_color_option brblack --bold

# comments like "# important"
set fish_color_comment 777

# parameter expansion operators like * and ~
set fish_color_operator magenta

# character escapes like \n and \x70
set fish_color_escape cyan

# autosuggestions (the proposed rest of a command)
set fish_color_autosuggestion 555

# the ^C indicator on a canceled command
set fish_color_cancel brblack

# history search matches and selected pager items (background only)
set fish_color_search_match --background=brblack

# current position in the history in dirh output
set fish_color_history_current $fish_color_valid_path

# the progress bar at the bottom left corner
set fish_pager_color_progress magenta

# the prefix string, i.e. the string that is to be completed
set fish_pager_color_prefix white --bold

# the completion itself, i.e. the proposed rest of the string
set fish_pager_color_completion white --dim

# the completion description
set fish_pager_color_description 550

# background of the selected completion
set fish_pager_color_selected_background --background=333

# prefix of the selected completion
set fish_pager_color_selected_prefix white --bold

# suffix of the selected completion
set fish_pager_color_selected_completion white --dim

# description of the selected completion
set fish_pager_color_selected_description 550
