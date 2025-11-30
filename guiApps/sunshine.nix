{ config, pkgs, ... }:

{
  services.sunshine = {
    enable = true;
    autoStart = true;      # start Sunshine for the user session
    capSysAdmin = true;    # required for DRM/KMS capture if you need it
    openFirewall = true;

    # Use the 'applications' option (module will generate apps.json)
    applications = {
      # optional env for apps; keep if you need to modify PATH etc.
      env = {
        # PATH can be adjusted if needed; leave empty or add entries
        PATH = "";
      };

      apps = [
        {
          name = "Steam Big Picture";
          # Replace 1000 with your UID if different (get it with `id -u <user>`).
          cmd = "sh -c 'export XDG_RUNTIME_DIR=/run/user/1000; export DISPLAY=:0; export WAYLAND_DISPLAY=wayland-0; setsid steam steam://open/bigpicture'";
          # onClose: only exit Big Picture mode via DBus (keeps Steam running)
          onClose = [
            "dbus-send --print-reply --session --dest=com.valvesoftware.Steam /com/valvesoftware/Steam com.valvesoftware.Steam.ExitBigPictureMode"
          ];
          autoStart = false;  # do not auto-start this app (Moonlight will launch it)
        }
      ];
    };
  };

  # keep your graphics enable setting
  hardware.graphics.enable = true;
}
