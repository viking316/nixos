{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... } @ inputs: {
	nixosConfigurations.bigscroll = nixpkgs.lib.nixosSystem {
	
		specialArgs = { inherit inputs; };

		modules = [
			./configuration.nix
		];
	
    	};
    
  };

}
