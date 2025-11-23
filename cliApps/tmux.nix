# In your tmux.nix file
{pkgs, pkgs-unstable, lib, inputs, conf, ...}:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs-unstable.tmuxPlugins; [
      tmux-which-key
      session-wizard
      tmux-toggle-popup
    ];

    extraConfig = ''
      # --- GENERAL ---
      unbind C-z
      # Terminal type and true color support configuration
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",xterm-256color:RGB"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[2 q'
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      set -g allow-passthrough on
      set -g escape-time 0
      set-window-option -g mode-keys vi
      set -g status-position top
      set -g mouse on
      set -g repeat-time 1000
      set -g focus-events on

      # Status bar configuration with consistent padding
      set -g status-style "fg=#cdd6f4,bg=#1e1e2e"
      set -g status-left-length "90"
      set -g status-right-length "90"
      set -g status-left " "
      set -g status-right "#[fg=#fab387,bg=#1e1e2e] it's %H:%M | %d-%m-%Y "
      
      # Window status formatting with consistent padding
      setw -g window-status-current-style "fg=#f5c2e7,bg=#313244"
      setw -g window-status-current-format " #I | #W "
      setw -g window-status-style "fg=#6c7086,bg=#1e1e2e"
      setw -g window-status-format " #I | #W "
      
      # Pane configuration with 1px padding
      set -g pane-border-style "fg=#313244"
      set -g pane-active-border-style "fg=#b4befe"
      set -g pane-border-status "off"
      set -g pane-border-format ""
      set -g pane-border-lines "heavy"
      
      # --- KEYBINDINGS ---
      # Splits
      unbind %
      unbind '"'
      bind C-v copy-mode
      bind e detach-client
      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -v -c "#{pane_current_path}"

      #window switching
      bind a previous-window
      bind d next-window

      # Pane switching with prefix key (C-b)
      bind C-j select-pane -D
      bind C-k select-pane -U
      bind C-h select-pane -L
      bind C-l select-pane -R

      # Session management
      unbind t
      bind t new-session -A -s "popup" "session-wizard"

      # Copy mode configuration
      bind -T copy-mode-vi v send-keys -X begin-selection
      unbind [
      bind p paste-buffer
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"

      # Copy mode movement
      bind -T copy-mode-vi k send-keys -X cursor-up
      bind -T copy-mode-vi j send-keys -X cursor-down
      bind -T copy-mode-vi h send-keys -X cursor-left
      bind -T copy-mode-vi l send-keys -X cursor-right
      
      # Unbind default movement keys
      unbind -T copy-mode-vi Up
      unbind -T copy-mode-vi Down
      unbind -T copy-mode-vi Left
      unbind -T copy-mode-vi Right
    '';
  };
}
