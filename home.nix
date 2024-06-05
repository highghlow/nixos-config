{ lib, config, pkgs, inputs, ... }:

{
  home.username = "nixer";
  home.homeDirectory = "/home/nixer";

  imports = [
    ./nogit/home.nix

    ./modules/home/git.nix
    ./modules/home/sway.nix
    ./modules/home/passwd.nix
    ./modules/home/firefox.nix
    ./modules/home/neovim.nix
    ./modules/home/polkit-auth.nix
  ];

  home.packages = with pkgs; [
    neofetch
    
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}    
