# home.nix
# ...
{pkgs, inputs, config, lib, ...}:
{
    services.vicinae = {
        enable = true; # default: false
        autoStart = true; # default: true
        # package = # specify package to use here. Can be omitted.
        settings = {
          theme.name = "catppuccin-mocha";
          window = {
            rounding = 0;
          };
        };
    };
}
