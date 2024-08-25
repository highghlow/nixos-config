{ lib, config, pkgs, inputs, ... }:

{
  home.username = "nixer";
  home.homeDirectory = "/home/nixer";

  imports = [
    ../../modules/home/all.nix
  ];

  mynixos.home = {
    bundle = {
      basic.enable = true;
      desktop = {
        enable = true;
	environment = "gnome";
      };
      apps = {
        firefox = true;
	communication = true;
	passwd = true;
	obsidian = true;
	gimp = true;
	libreoffice = true;
	mpv = true;
	unity = true;
	localsend = true;
	davinci-resolve = true;
      };
      neovim.enable = true;
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
