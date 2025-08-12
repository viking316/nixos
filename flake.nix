{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	
		specialArgs = { inherit inputs; };

		modules = [
			./configuration.nix
		];
	
    	};
    
  };
