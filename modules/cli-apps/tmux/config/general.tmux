# Lower delay waiting for chord after escape key press.
set -sg escape-time 0

# Unbind tmux default prefix and set to Ctrl + Space
unbind C-b
set -g prefix C-Space

# Enable mouse control
set -g mouse on

# Pane splitting
unbind v
unbind h
unbind %
unbind '"'
bind v split-window -h -c "#{pane_current_path}"
bind s split-window -v -c "#{pane_current_path}"

# Windowing
unbind n
unbind w
bind n command-prompt "rename-window '%%'"
bind w new-window -c "#{pane_current_path}"

# Start window numbers at 1 rather than 0.
set -g base-index 1
setw -g pane-base-index 1

# More history log
set -g history-limit 100000

# Vi bindings in copy mode
# Prefix (Ctrl + Space) + [ to enter copy mode, q returns to insert mode
set-window-option -g mode-keys vi

# Clipboard
unbind -T copy-mode-vi Space;
unbind -T copy-mode-vi Enter;
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel --clipboard"

# Fix colors being wrong in programs like Neovim.
set-option -ga terminal-overrides ",xterm-256color:Tc"

# Expand the left status to accomodate longer session names.
set-option -g status-left-length 20

# One of the plugins binds C-l, make sure we have accces to it.
unbind C-l
bind -n C-l send-keys C-l

# Don't require a prompt to detach from the current session.
unbind -n M-E
bind -n M-E detach-client

# Reload tmux configuration from ~/.config/tmux/tmux.conf instead
# of Tilish's default of ~/.tmux.conf.
unbind r
bind r source-file "~/.config/tmux/tmux.conf"

# Use 24 hour clock.
setw -g clock-mode-style 24

# Aggressively resize.
setw -g aggressive-resize on
