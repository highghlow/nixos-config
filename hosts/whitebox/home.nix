{ lib, config, pkgs, inputs, ... }:

{
  home.username = "nixer";
  home.homeDirectory = "/home/nixer";

  imports = [
    ../../nogit/home.nix

    ../../modules/home/all.nix
  ];

  mynixos.home = {
    bundle = {
      basic.enable = true;
      desktop = {
        enable = true;
	environment = "sway";
      };
      neovim = {
        enable = true;
	tmux = true;
	ctrl-semicolon-bypass = true;
      };
      apps = {
        communication = true;
	games = true;
	passwd = true;
	vm = true;
	transmission = true;
	firefox = true;
      };
    };

    firefox = {
      search = "searx";
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}    
