{
  description = "My first flake";

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    
    zen-browser = {
    	url = "github:0xc000022070/zen-browser-flake";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
    	url = "github:nix-community/home-manager";
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

  outputs = { nixpkgs, ... } @ inputs:

#-----------------------------------
  let

	system = "x86_64-linux";
  # homepkgs = nixpkgs.legacyPackages.${system};
  pkgs = nixpkgs.legacyPackages.${system};

  in
#-----------------------------------
  {
  #importing all my shells:
  devShells.${system}.capstone = (import ./shells/capstone.nix {inherit pkgs ;});
  
	#this is for the system so we pass the host name which is bigscroll in this case
	nixosConfigurations.bigscroll = nixpkgs.lib.nixosSystem {
	
		specialArgs = { inherit inputs; };
		
		modules = [
      #./home.nix		  
			./configuration.nix
		];
	
    	};

	#i am commenting out the belopw lines cuz i switched to integrated method where home-manager is triggered by nixos-rebuild switch and the below code is no longer req
    	#here for home manager we give the user name and not the host name 
	#as the packages will be installed only for that user
#	homeConfigurations.big_scroll = inputs.home-manager.lib.homeManagerConfiguration {
#		#extraSpecialArgs is literally specialArgs but just the HM version.
#		extraSpecialArgs = { inherit inputs; };
#		pkgs = homepkgs;
#		modules = [
#			./home.nix
#		];
#	
#   	};
  };

}
