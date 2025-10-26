{config, lib, pkgs, ...}:
{
  

programs.ssh = {
    enable = true;

  
    enableDefaultConfig = false;


    matchBlocks = {
       
      "*" = {
        # These options were moved from the top level.
        addKeysToAgent = "yes";
        compression = true;
        serverAliveInterval = 60;
        sendEnv = ["TMUX"];
      
        # Use Oracle Cloud key as the default for everything.
        # Note `identityFiles` (plural) takes a list.
        identityFile = [ "~/.ssh/oraclecloud_opensshnew" ];
      };

      # This block applies ONLY to github.com and overrides the "*" block.
      "github.com" = {
        hostname = "github.com";
        user = "git";
        # This specifies the GitHub-specific key.
        identityFile = [ "~/.ssh/github" ];
      };
    };
  };
  services.ssh-agent.enable = true;
}
