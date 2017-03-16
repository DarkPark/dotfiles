# if not running interactively don't do anything
case $- in *i*) ;; *) return;; esac

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# setting history length
HISTSIZE=50000
HISTFILESIZE=50000

# builtin time command output format
export TIMEFORMAT="real:%R user:%U sys:%S cpu:%P"

# prompt customization
. ~/.bash_prompt

# alias definitions
. ~/.bash_aliases

# enable programmable completion features
. /usr/share/bash-completion/bash_completion
