# In your tmux.nix file
{pkgs, lib,inputs, conf, ...}:

{
  programs.tmux = {
    enable  = true;
    plugins = with pkgs.tmuxPlugins;[
      tmux-which-key
      session-wizard
      tmux-toggle-popup
    ];

    extraConfig = ''
      # --- GENERAL ---
      # Default prefix (C-b) is active.
      # Added escape-time 0 for instant responsiveness in Helix.
      # Terminal type and true color support configuration
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",xterm-256color:RGB"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      # Ensure proper font rendering
      set -g allow-passthrough on
      set -g escape-time 0
      set-window-option -g mode-keys vi
      set -g status-position top
      set -g mouse on
      set -g repeat-time 1000
      # Enable focus events for better terminal integration
      set -g focus-events on
      # --- KEYBINDINGS ---
      # Splits (no change)
      unbind %
      unbind '"'
      bind C-v copy-mode
      bind e detach-client
      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -v -c "#{pane_current_path}"

      # FIX: Pane switching now requires the prefix key (C-b)
      bind C-j select-pane -L
      bind C-i select-pane -U
      bind C-k select-pane -D
      bind C-l select-pane -R

      # Window navigation with 'a' and 'd' (requires prefix)
      unbind d
      bind C-a previous-window
      bind C-d next-window

      # Session Wizard on <prefix> + t
      unbind t
      bind t new-session -A -s "popup" "session-wizard"

      # --- YANK/PASTE WORKFLOW ---
      
      bind -T copy-mode-vi v send-keys -X begin-selection
      # Unbind the old key for entering copy mode
      unbind [

      # NEW: <prefix> + p pastes from the buffer
      bind p paste-buffer

      # 'y' in copy mode still copies to Wayland clipboard
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"

      # --- CUSTOM COPY-MODE MOVEMENT ---
      # NEW: Remapped ijkl for cursor movement in copy mode
      bind -T copy-mode-vi i send-keys -X cursor-up
      bind -T copy-mode-vi k send-keys -X cursor-down
      bind -T copy-mode-vi j send-keys -X cursor-left
      bind -T copy-mode-vi l send-keys -X cursor-right
      # Unbind default keys to avoid confusion
      unbind -T copy-mode-vi Up
      unbind -T copy-mode-vi Down
      unbind -T copy-mode-vi Left
      unbind -T copy-mode-vi Right

      # --- THEME (Catppuccin Mocha) ---
      # Status bar (no change)
      set -g status-style 'fg=#cdd6f4,bg=#1e1e2e'
      set -g status-left-length 90
      #set -g status-left '#[fg=#a6e3a1,bg=#1e1e2e] #(git branch --show-current 2>/dev/null)'
      set -g status-right-length 90
      set -g status-right "#[fg=#fab387,bg=#1e1e2e] it's %H:%M | %d-%m-%Y "
      setw -g window-status-current-style 'fg=#f5c2e7,bg=#313244'
      setw -g window-status-current-format ' #I | #W '
      setw -g window-status-style 'fg=#6c7086,bg=#1e1e2e'
      setw -g window-status-format ' #I | #W '
      set -g pane-border-style 'fg=#313244'
      set -g pane-active-border-style 'fg=#b4befe'
      set -g pane-border-status off
    '';
  };
}
