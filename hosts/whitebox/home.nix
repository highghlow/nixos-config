{ lib, config, pkgs, inputs, ... }:

{
  home.username = "nixer";
  home.homeDirectory = "/home/nixer";

  imports = [
    ../../nogit/home.nix

    ../../modules/home/git.nix
    ../../modules/home/sway.nix
    ../../modules/home/passwd.nix
    ../../modules/home/firefox.nix
    ../../modules/home/neovim.nix
    ../../modules/home/transmission.nix
    ../../modules/home/polkit-auth.nix
    ../../modules/home/virt-manager.nix
    ../../modules/home/zsh.nix
    ../../modules/home/games.nix
    ../../modules/home/discord.nix
    ../../modules/home/telegram.nix
    ../../modules/home/comma.nix
  ];

  home.packages = with pkgs; [
    neofetch
    
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}    
