{config, pkgs,lib, ...}:

{

	programs.ghostty = {

		enable = true;
		enableZshIntegration = true;
		enableFishIntegration = true;
		enableBashIntegration = true;
		settings = {
			font-family = "JetBrains Mono";

		};



	};

}
