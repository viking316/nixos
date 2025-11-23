{ config, pkgs, pkgs-unstable ,inputs, ... }:

{

  imports = [
  ./guiApps/vsc.nix
  ./guiApps/vicinae.nix
  ./cliApps/lazydocker.nix
	./cliApps/git.nix
	./cliApps/zsh.nix
	./cliApps/ghostty.nix	
 	./cliApps/fzf.nix
	./cliApps/helix.nix
	./guiApps/plasma-manager.nix
	./cliApps/tmux.nix
	./cliApps/ssh.nix
	
	inputs.plasma-manager.homeManagerModules.plasma-manager
	inputs.vicinae.homeManagerModules.default
  ];
  nixpkgs.config.allowUnfree = true;
# Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "big_scroll";
  home.homeDirectory = "/home/big_scroll";
  
  home.sessionPath = [
    "$HOME/.local/bin"
  ];


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    #ONLY GLOBAL PKGS ARE DEFINED HERE
    #I HAVE PUT ALL THE PKGS REQ FOR THE MODULES IN THEIR OWN FILES INSTEAD OF HERE GLOBALLY.
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager manages dotfiles via 'home.file'. Keep configured files below.
  #autostart syncthing:
    # custom gitblame command for helix editor T_T
  home.file.".local/bin/gblame" = {
    source = ./hardcoded/gblame;
    executable = true;
  };
  
  #these are the confs for refind(bootloader)
  home.file."/boot/EFI/refind/refind.conf".source =  hardcoded/refind.conf;
  home.file."/boot/EFI/refind/icons/pill.png".source = hardcoded/pill.png;
  # Environment variables for Home Manager-managed shells.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
