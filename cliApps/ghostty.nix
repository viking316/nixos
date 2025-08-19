{config, pkgs,lib, ...}:

{

	programs.ghostty = {

		enable = true;
		enableZshIntegration = true;
		enableFishIntegration = true;
		enableBashIntegration = true;
		settings = {
			font-family = "JetBrains Mono";
			
			cursor-style = "block";
			mouse-hide-while-typing = true;
			background-opacity = 0.85;
			window-padding-x = 2;
			window-padding-y = 2;
			theme = "catppuccin-mocha";
			background-blur = true;
		};



	};

}
