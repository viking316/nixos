{ pkgs, ... }:

{
  systemd.user.services.syncthing = {
    Unit = {
      Description = "Syncthing - Open Source Continuous File Synchronization";
      Documentation = "man:syncthing(1)";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.syncthing}/bin/syncthing -no-browser -no-restart";
      Restart = "on-failure";
      RestartSec = "5";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
