# In cliApps/fzf.nix
{ pkgs, ... }:


{
	home.packages = with pkgs;[fd bat tree];
  programs.fzf = {
    enable = true;
    enableZshIntegration = true; # Or enableBashIntegration = true;

    # --- THEME (Catppuccin Mocha) ---
    # This sets the colors for all fzf widgets
    colors = {
      "fg"      = "#cdd6f4"; # Text
      "fg+"     = "#cdd6f4"; # Text (current line)
      "bg"      = "#1e1e2e"; # Base
      "bg+"     = "#313244"; # Surface0 (current line)
      "hl"      = "#a6e3a1"; # Green (highlight)
      "hl+"     = "#a6e3a1"; # Green (highlight on current line)
      "info"    = "#b4befe"; # Lavender
      "border"  = "#b4befe"; # Lavender
      "prompt"  = "#89dceb"; # Sky
      "pointer" = "#f5e0dc"; # Rosewater
      "marker"  = "#f5e0dc"; # Rosewater
      "spinner" = "#f5c2e7"; # Pink
      "header"  = "#b4befe"; # Lavender
    };

    # --- LAYOUT ---
    # These options apply to all fzf commands for a consistent, neat look
    defaultOptions = [
      "--height 60%"
      "--layout=reverse"
      "--border=double"
      "--margin='2%'" # Padding on all sides
      "--padding='1'"  # Internal padding
      "--preview-window='border-rounded'"
    ];

    # --- COMMANDS (fd-based) ---
    # FIX: Added your requested exclusions
    defaultCommand = "fd --type f --hidden . '/' --strip-cwd --exclude .git --exclude node_modules --exclude .nix-defexpr --exclude .cache --exclude .local/share/Trash";

    # For Ctrl+t (insert file path)
    # FIX: Added your requested exclusions
    fileWidgetCommand = "fd --type f --hidden . '/' --strip-cwd --exclude .git --exclude node_modules --exclude .nix-defexpr --exclude .cache --exclude .local/share/Trash";
    fileWidgetOptions = [
      "--preview 'bat --color=always --style=plain {}'"
    ];

    # For Alt+c (change directory)
    # FIX: Added your requested exclusions
    changeDirWidgetCommand = "fd --type d --hidden . '/' --strip-cwd --exclude .git --exclude node_modules --exclude .nix-defexpr --exclude .cache --exclude .local/share/Trash";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -100'"
    ];
  };
}
