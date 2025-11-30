# Desktop Environments

This folder contains isolated configurations for different Desktop Environments.

## Structure

```
desktops/
├── default.nix        # System-level DE selector (edit to switch DEs)
├── home-default.nix   # Home-manager DE selector (keep in sync with default.nix)
├── plasma/
│   ├── system.nix     # KDE Plasma - NixOS system config
│   └── home.nix       # KDE Plasma - Home Manager config
├── gnome/             # (TODO) GNOME configuration
│   ├── system.nix
│   └── home.nix
└── hyprland/          # (TODO) Hyprland configuration
    ├── system.nix
    └── home.nix
```

## How to Switch Desktop Environments

1. **Edit `desktops/default.nix`** - Comment out the current DE and uncomment the one you want:
   ```nix
   imports = [
     # ./plasma/system.nix    # Comment this out
     ./gnome/system.nix       # Uncomment this
   ];
   ```

2. **Edit `desktops/home-default.nix`** - Do the same for home-manager:
   ```nix
   imports = [
     # ./plasma/home.nix      # Comment this out
     ./gnome/home.nix         # Uncomment this
   ];
   ```

3. **Rebuild your system:**
   ```bash
   sudo nixos-rebuild switch --flake .#bigscroll
   # Or using nh:
   nh os switch
   ```

## Adding a New Desktop Environment

1. Create a new folder: `desktops/<de-name>/`
2. Create `system.nix` with NixOS-level settings (display manager, DE services, DE packages)
3. Create `home.nix` with user-level settings (themes, panels, app configs)
4. Add the import options to `default.nix` and `home-default.nix`

## What Goes Where?

### system.nix (NixOS configuration)
- Display manager (sddm, gdm, lightdm, greetd)
- Desktop manager services
- System-wide packages for the DE
- Firewall rules specific to DE apps
- X11/Wayland configuration

### home.nix (Home Manager configuration)
- Themes (GTK, Qt, icons, cursors)
- Panel/bar configuration
- DE-specific user apps
- Keyboard shortcuts
- Window manager settings
