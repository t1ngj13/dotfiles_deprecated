##############################
#  _
# | |_ _ __ ___  _   ___  __
# | __| '_ ` _ \| | | \ \/ /
# | |_| | | | | | |_| |>  <
#  \__|_| |_| |_|\__,_/_/\_\
#
#############################
bind r source-file ${HOME}/.tmux.conf \; display-message "source-file reloaded"

#
# COPY AND PASTE
# http://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future
#
# Use vim keybindings in copy mode
setw -g mode-keys vi

############################################################################
############################################################################
# Reset Prefix
############################################################################
set -g prefix C-o
bind-key a send-prefix # for nested tmux sessions

############################################################################
# Global options
############################################################################
# large history
set-option -g history-limit 10000

# Allows for faster key repetition
set -s escape-time 0

# colors
# setw -g mode-bg black
set-option -g default-terminal "screen-256color" #"xterm-256color" # "screen-256color"
# set-option -g default-terminal "screen-256color" #"xterm-256color" # "screen-256color"
set-option -g pane-active-border-fg blue

# utf8 support
set-window-option -g utf8 on

# basic settings
set-window-option -g xterm-keys on # for vim
set-window-option -g mode-keys vi # vi key
set-window-option -g monitor-activity on
set -g visual-activity on
# set-window-option -g window-status-current-fg white
# setw -g window-status-current-attr reverse

# Automatically set window title
setw -g automatic-rename

# vi movement keys
set-option -g status-keys vi

############################################################################
# windows
############################################################################
# set-window-option -g window-status-current-bg red
# bind C-j previous-window
# bind C-k next-window
# bind-key C-a last-window # C-a C-a for last active window
# bind A command-prompt "rename-window %%"
# # By default, all windows in a session are constrained to the size of the
# # smallest client connected to that session,
# # even if both clients are looking at different windows.
# # It seems that in this particular case, Screen has the better default
# # where a window is only constrained in size if a smaller client
# # is actively looking at it.
# setw -g aggressive-resize on

############################################################################
# Status Bar
# ############################################################################
set-option -g status-utf8 on
set-option -g status-justify right
set-option -g status-interval 5
set-option -g status-left-length 30
set-option -g visual-activity on

source-file $HOME/dotfiles/airline.tmux

############################################################################
# Unbindings
# ############################################################################
#unbind [ # copy mode bound to escape key
unbind j
unbind C-b # unbind default leader key
unbind '"' # unbind horizontal split
unbind %   # unbind vertical split

###########################################################################
# panes
# ############################################################################
bind | split-window -h
bind - split-window -v

# # Navigation ---------------------------------------------------------------
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

# Resizing ---------------------------------------------------------------
bind -r C-h resize-pane -L 5
bind -r C-j resize-pane -D 5
bind -r C-k resize-pane -U 5
bind -r C-l resize-pane -R 5

# unbind arrow keys. This prevents cases where you switch
# to a different pane, then use the arrow key to go through
# command history, and accidentally switch back to the previous
# pane
unbind Up
unbind Down
unbind Left
unbind Right

############################################################################
# layouts
# ############################################################################
bind o select-layout "active-only"
bind M-- select-layout "even-vertical"
bind M-| select-layout "even-horizontal"
bind M-r rotate-window

############################################################################
# Mouse
# ############################################################################
# disable mouse support (at least while we're learning)
# setw -g mode-mouse off
# set -g mouse-select-pane off
# set -g mouse-resize-pane off
# set -g mouse-select-window off


############################################################################
# Copy and Paste
# ###########################################################################
# copy/paste using vim-style keys
bind Escape copy-mode
unbind p
bind p paste-buffer
bind -t vi-copy 'v' begin-selection
bind -t vi-copy 'y' copy-selection

# xclip support (commented as this often doesn't make sense on remote servers)
#bind C-c run "tmux save-buffer - / xclip -i -sel clipboard"
#bind C-v run "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"

# set up alias for turning on logging
bind P pipe-pane -o "cat >>~/#W.log" \; display "Toggled logging to ~/#W.log"
