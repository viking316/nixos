# Desktop Environment Home Manager Selector
# ===========================================
# This file selects which DE's home-manager config to use.
# Keep this in sync with desktops/default.nix
#
# USAGE:
# 1. When switching DE in default.nix, also switch here
# 2. Comment out the current DE and uncomment the one you want
# ===========================================

{ ... }:

{
  imports = [
    # ========== ACTIVE DESKTOP ENVIRONMENT ==========
    # Only ONE home.nix should be imported at a time!
    
    # KDE Plasma 6
    ./plasma/home.nix
    
    # GNOME (uncomment to use, comment out Plasma above)
    # ./gnome/home.nix
    
    # Hyprland (uncomment to use, comment out others above)
    # ./hyprland/home.nix
    
    # =================================================
  ];
}
