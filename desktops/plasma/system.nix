# KDE Plasma 6 - System-level configuration
# This file contains NixOS system-level settings for KDE Plasma
{ config, pkgs, ... }:

{
  # Enable X11 windowing system (required for both X11 and Wayland sessions)
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # SDDM Display Manager with Catppuccin theme
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
  };

  # Enable Plasma 6 Desktop Environment
  services.desktopManager.plasma6.enable = true;

  # KDE Plasma specific packages
  environment.systemPackages = with pkgs; [
    # SDDM theme
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      background = "${../../hardcoded/second_dragon_blue.png}";
      loginBackground = true;
    })

    # KDE specific apps
    kdePackages.kate
    kdePackages.kdeconnect-kde
  ];

  # NOTE: KDE Connect firewall ports are configured in the main configuration.nix
  # alongside LocalSend and other shared network settings

  # NOTE: qtwebengine insecure package permission is in flake.nix
  # because pkgs is passed via specialArgs (nixpkgs.config in modules is ignored)
}
