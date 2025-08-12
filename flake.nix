{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    zen-browser = {
	url = "github:0xc000022070/zen-browser-flake";
	inputs.nixpkgs.follows = "nixpkgs";
    };

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
