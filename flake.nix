{
  description = "My first flake";

  inputs = {
    # Stable is the primary channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Unstable for cherry-picked packages only
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    
    zen-browser = {
    	url = "github:0xc000022070/zen-browser-flake";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
    	url = "github:nix-community/home-manager/release-25.05";
    	inputs.nixpkgs.follows = "nixpkgs";

    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    vicinae.url = "github:vicinaehq/vicinae";
  };

  nixConfig = {
    extra-substituters = [ "https://vicinae.cachix.org" ];
    extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];

  };

  outputs = { nixpkgs-unstable, nixpkgs, ... } @ inputs:

#-----------------------------------
  let

	system = "x86_64-linux";
  # Stable is the default package set
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  # Unstable is available for cherry-picked packages
  pkgs-unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  in
#-----------------------------------
  {
  #importing all my shells:
  devShells.${system}.capstone = (import ./shells/capstone.nix {inherit pkgs ;});
  
	#this is for the system so we pass the host name which is bigscroll in this case
	nixosConfigurations.bigscroll = nixpkgs.lib.nixosSystem {
	
		specialArgs = {
		  inherit inputs pkgs pkgs-unstable;
		};
		
		modules = [
			./configuration.nix
    	./guiApps/sunshine.nix

    ];
	
    	};

  };

}
