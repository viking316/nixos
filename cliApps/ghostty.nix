{config, pkgs,lib, ...}:

{

	programs.ghostty = {

		enable = true;
		enableZshIntegration = true;
		enableFishIntegration = true;
		enableBashIntegration = true;
		settings = {
			font-family = "JetBrains Mono Nerd Font";
			font-feature = "-calt +zero +cv02 +cv05 +cv09 +cv14 +ss04 +cv16 +cv31 +cv25 +cv26 +cv32 +cv28 +ss10 +zero +onum";
			font-size = 12;
			font-thicken = true;
			
			# Terminal and tmux settings
			term = "xterm-256color";
			shell-integration = "none";
			cursor-style = "block";
			mouse-hide-while-typing = true;
			background-opacity = 0.85;
			window-padding-x = 0;
			window-padding-y = 0;
			theme = "catppuccin-mocha";
			background-blur = true;
		};



	};

}
