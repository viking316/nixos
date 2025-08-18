{config, pkgs,lib, ...}:

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
      # Automatically start tmux if not already inside a tmux session
      if [[ -z "$TMUX" && "$-" == *i* ]]; then
        exec tmux -u
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
      # FIX: Main format string now just lists the modules
      format = "$shell$username$directory$git_branch$character";
      
      git_branch.symbol = " ";

      character = {
        success_symbol = "[❯](bold #a6e3a1)";
        error_symbol = "[❯](bold #f38ba8)";
      };

      # --- Module Styles (Catppuccin Mocha with Block Style) ---
      # FIX: Removed the Powerline arrow '' from all module formats
      shell = {
        format = "[$indicator]($style)";
        style = "bg:#181825 fg:#CDD6F4";
        zsh_indicator = " zsh ";
        disabled = false;
      };
      username = {
        format = "[ $user ]($style_user)";
        style_user = "bg:#1E1E2E fg:#CDD6F4";
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
