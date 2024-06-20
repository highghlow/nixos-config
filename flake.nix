{
  description = "My NixOS flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, nur, stylix, nixvim, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [
	  nur.nixosModules.nur
	  stylix.nixosModules.stylix

	  ./colorscheme.nix
	  ./hosts/whitebox/configuration.nix
	  ./nogit/configuration.nix

	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.sharedModules = [
	      nixvim.homeManagerModules.nixvim
	      nur.nixosModules.nur
	    ];
	    home-manager.users.nixer = import ./hosts/whitebox/home.nix;
	  }
	];
      };
    };
  };
}
