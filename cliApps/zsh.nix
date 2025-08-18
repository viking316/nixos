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
      export VIVID_THEME='catppuccin-mocha'
      export LS_COLORS="$(vivid generate "$VIVID_THEME")"

      # --- PROMPT SETUP ---
      # Load the version control information system
      autoload -Uz vcs_info
      precmd() { vcs_info }

      # Define the format for the git branch string (using Catppuccin Mauve)
      # NOTE: The '' icon requires a Nerd Font.
      zstyle ':vcs_info:git:*' formats '(%F{#cba6f7} %b%f)'
      
      # Don't show anything when not in a git repo
      zstyle ':vcs_info:*' no-vcs ""

      # Set the final prompt for Catppuccin Mocha with git info
      PROMPT="
%K{#181825}%F{#CDD6F4} $0 %K{#1E1E2E}%F{#CDD6F4} %n %K{#313244}%F{#CDD6F4} %~ %f%k %F{#89B4FA} ''${vcs_info_msg_0_} %f%F{#A6E3A1} ❯ %f"
      # Welcome message
				echo -e "
\x1b[48;5;236m\x1b[38;5;189m $(${lib.getExe' pkgs.procps "uptime"} -p | cut -c 4-) \x1b[48;5;238m\x1b[38;5;189m $(uname -r) \033[0m" #catppuccin-mocha theme
    '';
  };
}
