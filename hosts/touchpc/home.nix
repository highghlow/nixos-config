{ lib, config, pkgs, inputs, ... }:

{
  home.username = "nixer";
  home.homeDirectory = "/home/nixer";

  imports = [
    ../../modules/home/git.nix
  ];

  home.packages = with pkgs; [
    neofetch
    
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}    
