# Create a new file at /etc/nixos/plasma.nix
{ pkgs, ... }:

{
  # 1. INSTALL THEME PACKAGES
  home.packages = with pkgs; [
    catppuccin-kde
    catppuccin-gtk
    catppuccin-cursors
    papirus-icon-theme
  ];

  # 2. CONFIGURE GTK (for non-KDE apps to match)
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme.name = "Papirus-Dark";
    cursorTheme.name = "Catppuccin-Mocha-Dark";
  };

  # 3. CONFIGURE PLASMA
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

    # Your custom panel layout
    panels = [{
      location = "bottom";
      height = 36;
      widgets = [
        # 0: workspaces indicator
        "org.kde.plasma.pager"
        # 1: spacer
        "org.kde.plasma.panelspacer"
        # 2: apps (task manager)
        {
          iconTasks.launchers = [
            "applications:org.kde.dolphin.desktop"
            "applications:org.kde.konsole.desktop"
            "applications:firefox.desktop"
          ];
        }
        # 3: spacer
        "org.kde.plasma.panelspacer"
        # 4: system tray
        "org.kde.plasma.systemtray"
        # 5: desktop peek
        "org.kde.plasma.showdesktop"
      ];
    }];

    # Quality-of-life settings
    configFile."baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
  };
}
