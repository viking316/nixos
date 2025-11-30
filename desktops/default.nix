# Desktop Environment Selector
# ===========================================
# This file acts as a central point to switch between different DEs.
# 
# USAGE:
# 1. To switch DE, change the imports below
# 2. Comment out the current DE and uncomment the one you want
# 3. Run: sudo nixos-rebuild switch --flake .#bigscroll
#
# Available DEs:
# - plasma: KDE Plasma 6 with Catppuccin theme
# - gnome: GNOME (TODO: create desktops/gnome/)
# - hyprland: Hyprland tiling WM (TODO: create desktops/hyprland/)
# ===========================================

{ ... }:

{
  imports = [
    # ========== ACTIVE DESKTOP ENVIRONMENT ==========
    # Only ONE system.nix should be imported at a time!
    
    # KDE Plasma 6
    ./plasma/system.nix
    
    # GNOME (uncomment to use, comment out Plasma above)
    # ./gnome/system.nix
    
    # Hyprland (uncomment to use, comment out others above)
    # ./hyprland/system.nix
    
    # =================================================
  ];
}
