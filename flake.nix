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
    nixvirt = {
      url = "github:highghlow/NixVirt/patch-2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
	nur.nixosModules.nur
	inputs.nixvirt.nixosModules.default

        ./colorscheme.nix
        ./configuration.nix
        ./nogit/configuration.nix

        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.sharedModules = [
            inputs.nixvim.homeManagerModules.nixvim
	    nur.nixosModules.nur
	    inputs.nixvirt.homeModules.default
          ];
          home-manager.users.nixer = import ./home.nix;
        }
      ];
    };
  };
}
