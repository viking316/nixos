{configs, pkgs, ...}:

{
	programs.zsh = {

		enable = true;

		shellAliases = {

			ls = "ls --color=auto";
			ll = "ls -alF";
			grep = "grep --color=auto";

		};

		history = {

			sizee = 30000;
			path = "${config.xdg.dataHome}/zsh/history";
			expireDuplicatesFirst = true;
			findNoDups = true;
			ignoreAllDUps = true;
			ignoreDups = true;
			ignoreSpace = true;
			saveNoDups = true;
			share = true;
			
		};
		
		syntaxHighlighting = {

			enable = true;
			highlighter = ["brackets" "root" "cursor"];
		};

		initContent =  let 

			header = lib.mkOrder 1500 ''' 
					NEWLINE='\n'
					echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme
				''';
				in

		{
			
			# set up prompt
			NEWLINE='\n'
			PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme
			# PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} $0 %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k ❯ " # warmer theme

		};




	}; 





}
