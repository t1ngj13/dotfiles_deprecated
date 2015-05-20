ZSH_THEME="agnoster"
plugins=(git autojump)
[[ $TMUX = "" ]] && export TERM="xterm-256color"
export EDITOR="vi"

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# alias for tmux
alias ta="tmux a"

# Make less output with syntax highlight
# Check http://superuser.com/questions/117841/get-colors-in-less-command
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS='-R'

