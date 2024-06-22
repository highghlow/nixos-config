# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ../../hardware-configuration.nix
      ./disk-config.nix

      ../../modules/root/grub.nix
      ../../modules/root/locale.nix
      ../../modules/root/gnome.nix
    ];

  users.users.nixer = {
    isNormalUser = true;
    description = "nixer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    password = "1";
  };

  networking.hostName = "nixos";
  time.timeZone = "Europe/Moscow";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
    vim
    sway
  ];

  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
