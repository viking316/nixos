{config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [vivid];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -alF";
      grep = "grep --color=auto";
    };

    history = {
      size = 30000;
      path = "${config.xdg.dataHome}/zsh/history";
      expireDuplicatesFirst = true;
      findNoDups = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      saveNoDups = true;
      share = true;
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = ["brackets" "root" "cursor"];
    };

    initContent = ''
      # Ensure proper terminal settings
      if [[ "$TERM" = "xterm-256color" ]]; then
        export COLORTERM=truecolor
      fi

      # Automatically start tmux, but not in VS Code's integrated terminal
      if [[ -z "$TMUX" && "$-" == *i* && "$TERM_PROGRAM" != "vscode" && ! -n "$NO_TMUX" ]]; then
        # Prevent recursive tmux spawning
        export NO_TMUX=1
        # Clear any existing TMUX environment variables
        unset TMUX TMUX_PANE

        if ! tmux has-session -t main 2>/dev/null; then
          exec tmux -u new-session -s main
        else
          exec tmux -u attach-session -t main
        fi
      fi

      # Set LS_COLORS theme
      export VIVID_THEME="catppuccin-mocha"
      export LS_COLORS="$(vivid generate "$VIVID_THEME")"

      # Welcome message
      echo -e "\x1b[48;5;236m\x1b[38;5;189m $(${pkgs.procps}/bin/uptime -p | cut -c 4-) \x1b[48;5;238m\x1b[38;5;189m $(uname -r) \033[0m"
    '';
  };

  # --- STARSHIP PROMPT CONFIGURATION ---
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      # Main format string now just lists the modules
      format = "$shell$username$directory$git_branch$character";

      git_branch.symbol = " ";

      character = {
        success_symbol = "[ ❯](bold #a6e3a1)";
        error_symbol = "[ ❯](bold #f38ba8)";
      };

      # --- Module Styles (Catppuccin Mocha with Block Style) ---
      shell = {
        format = "[$indicator]($style)";
        style = "bg:#181825 fg:#CDD6F4";
        zsh_indicator = " zsh ";
        disabled = false;
      };
      username = {
        format = "[](bg:#45475a)[ $env_name$user ](fg:#cdd6f4 bg:#45475a)[](fg:#45475a)";
        style_user = "fg:#cdd6f4 bg:#45475a";
        show_always = true;
      };
      directory = {
        format = "[ $path ]($style)";
        style = "bg:#313244 fg:#CDD6F4";
        truncation_length = 3;
      };
      git_branch = {
        format = "[$symbol$branch ]($style)";
        style = "bg:#1E1E2E fg:#cba6f7";
      };
    };
  };
}
