# KDE Plasma 6 - Home Manager configuration
# This file contains user-level settings for KDE Plasma (themes, panels, etc.)
{ pkgs, inputs, ... }:

{
  imports = [
    # Import plasma-manager module
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  # Install theme packages
  home.packages = with pkgs; [
    catppuccin-kde
    catppuccin-gtk
    catppuccin-cursors
    papirus-icon-theme
  ];

  # Configure GTK (for non-KDE apps)
  gtk = {
    # This will make sure only HM can manage the file and KDE doesn't overwrite
    gtk2.force = true;
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme.name = "Papirus-Dark";
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
  };

  # Configure Plasma via plasma-manager
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "com.catppuccin.mocha.dark";
      iconTheme = "Papirus-Dark";
      cursor.theme = "Catppuccin-Mocha-Dark";
    };

    fonts.general = {
      family = "JetBrains Mono";
      pointSize = 11;
    };

    panels = [{
      location = "bottom";
      height = 36;
      widgets = [
        # Workspaces Indicator
        "org.kde.plasma.pager"
        # Spacer
        "org.kde.plasma.panelspacer"

        {
          name = "org.kde.plasma.kickoff";
          config = {
            General = {
              # Use the blue NixOS snowflake icon
              icon = "nix-snowflake";
            };
          };
        }

        # Apps (Task Manager)
        {
          iconTasks.launchers = [
            "applications:org.kde.dolphin.desktop"
            "applications:org.kde.konsole.desktop"
            "applications:firefox.desktop"
          ];
        }
        # Spacer
        "org.kde.plasma.panelspacer"
        # System Tray
        "org.kde.plasma.systemtray"
        # Desktop Peek
        "org.kde.plasma.showdesktop"
      ];
    }];

    # Transparency and Blur Effects
    configFile = {
      # This enables the "Blur" effect backend in KWin
      "kwinrc"."Plugins"."blurEnabled" = true;

      # This disables the file indexer for better performance
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
    };
  };
}
