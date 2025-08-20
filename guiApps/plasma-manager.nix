# In /etc/nixos/plasma.nix
{ pkgs, ... }:

{
  # 1. INSTALL THEMES
  # Ensures all Catppuccin components are installed
  home.packages = with pkgs; [
    catppuccin-kde # This was the corrected name
    catppuccin-gtk
    catppuccin-cursors
    papirus-icon-theme
  ];

  # 2. CONFIGURE GTK (for non-KDE apps)
  gtk = {

    # this will make sure only HM can manage the file and kde dont overwrite 
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

    
    panels = [{
      location = "bottom";
      height = 36;
      widgets = [
        # 0: Workspaces Indicator
        "org.kde.plasma.pager"
        # 1: Spacer
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

        # 2: Apps (Task Manager)
        {
          iconTasks.launchers = [
            "applications:org.kde.dolphin.desktop"
            "applications:org.kde.konsole.desktop"
            "applications:firefox.desktop"
          ];
        }
        # 3: Spacer
        "org.kde.plasma.panelspacer"
        # 4: System Tray
        "org.kde.plasma.systemtray"
        # 5: Desktop Peek
        "org.kde.plasma.showdesktop"
      ];
    }];
    
    #Transparency and Blur Effects
    configFile = {
      # This enables the "Blur" effect backend in KWin
      "kwinrc"."Plugins"."blurEnabled" = true;

      # This disables the file indexer for better performance
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
    };
  };
}
