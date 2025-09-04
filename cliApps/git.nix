
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
	programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
    serverAliveInterval = 60;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";  # This should always be "git"

        identityFile = "~/.ssh/github";
      };
    };
  };

  services.ssh-agent.enable = true;

}
