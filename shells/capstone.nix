{pkgs}:
# In your shell.nix file
let
  # Import the specific, older version of nixpkgs from your commit
  oldpkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/fd04bea4cbf76f86f244b9e2549fca066db8ddff.tar.gz";
    sha256 = "05g8z05ydg1bvkc7hhivsz3a9fkf8dj1mfr976hacvpy33yzwsca";
    # To make this a pure evaluation, you would add a sha256 hash here.
  }){system = pkgs.system;};

in

# Use this single, consistent package set to build the shell
oldpkgs.mkShell {
  packages = with oldpkgs; [
    (python310.withPackages (p: with p; [
      numpy
      fastapi
      uvicorn
    ]))
  ];
  shellHook = ''
    echo "INSIDE CAPSTONE ENV"
 
  '';
}
