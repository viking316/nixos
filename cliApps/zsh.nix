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
		initExtra = ''
      			# Automatically start tmux if not already inside a tmux session
		        if [[ -z "$TMUX" && "$-" == *i* ]]; then
     			        # The `exec` command replaces the current shell process with tmux,
		        	# which is cleaner than just running it.
			        # The `-u` flag enables UTF-8 support.
        			exec tmux -u
		        fi

		        export VIVID_THEME="catppuccin-mocha"
		        export LS_COLORS="$(vivid generate "$VIVID_THEME")"
			    '';

		initContent =

		
			''
				# set up prompt(uncomment both lines if you wanna swithc)
				
				#PROMPT="
#%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme
				
				#PROMPT="
#%K{#32302f}%F{#d5c4a1} $0 %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k ❯ " # warmer theme
				PROMPT="
%K{#181825}%F{#CDD6F4} $0 %K{#1E1E2E}%F{#CDD6F4} %n %K{#313244}%F{#CDD6F4} %~ %f%k%F{#A6E3A1} ❯ %f" #catppuccin-mocha theme
						
				#echo -e "
#\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(${lib.getExe' pkgs.procps "uptime"} -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme

				#echo -e "
#\x1b[38;5;137m\x1b[48;5;0m it's $(date +%_I:%M%P) \x1b[38;5;180m\x1b[48;5;0m $(${lib.getExe' pkgs.procps "uptime"} -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # warmer theme
		
				echo -e "
\x1b[48;5;234m\x1b[38;5;189m it's $(date +%_I:%M%P) \x1b[48;5;236m\x1b[38;5;189m $(${lib.getExe' pkgs.procps "uptime"} -p | cut -c 4-) \x1b[48;5;238m\x1b[38;5;189m $(uname -r) \033[0m" #catppuccin-mocha theme

			'';
		




	}; 





}

