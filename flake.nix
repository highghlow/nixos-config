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
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    hw-config = {
      url = "file:///etc/nixos/hardware-configuration.nix";
      type = "file";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, stylix, nixvim, disko, agenix, hw-config, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [
	  nur.nixosModules.nur
	  stylix.nixosModules.stylix
	  inputs.nixvirt.nixosModules.default

	  ./colorscheme.nix
	  ./hosts/whitebox/configuration.nix
	  ./nogit/configuration.nix
	  hw-config.outPath

	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {inherit inputs;};
	    home-manager.sharedModules = [
	      nixvim.homeManagerModules.nixvim
	      nur.nixosModules.nur
	      inputs.nixvirt.homeModules.default
	    ];
	    home-manager.users.nixer = import ./hosts/whitebox/home.nix;
	  }
	];
      };
      laptop = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [
	  nur.nixosModules.nur
	  stylix.nixosModules.stylix
	  inputs.nixvirt.nixosModules.default
	  disko.nixosModules.disko
	  agenix.nixosModules.default

	  ./colorscheme.nix
	  ./hosts/laptop/configuration.nix
	  ./hosts/laptop/disk-config.nix
	  ./hosts/laptop/hardware-configuration.nix

	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {inherit inputs;};
	    home-manager.sharedModules = [
	      nixvim.homeManagerModules.nixvim
	      nur.nixosModules.nur
	      inputs.nixvirt.homeModules.default
	    ];
	    home-manager.users.nixer = import ./hosts/laptop/home.nix;
	  }
	];
      };
    };
  };
}
