
{config, pkgs, ...}:

{
	programs.git = {

		enable = true;
		userName = "Chandrashekar M";
		userEmail = "ironavenger10@gmail.com";
		extraConfig = {
			init.defaultBranch = "main";
		};

	};
}
