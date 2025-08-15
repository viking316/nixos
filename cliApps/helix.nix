{config, pkgs, lib, ...}:

{

	programs.helix = {

		enable = true;
		defaultEditor = true;
		themes.theme = "catppuccin-mocha";
		settings.editor = {

			line-number = "relative";
			lsp.display-messages = true;

		};


	};


}
