{pkgs, lib, config, ...}:


{

  wayland.windowManager.hyprland = {
    enable = true;
    
    systemd.enableXdgAutostart = true;
    # settings = {

      
    # };

    
  };
  
}
