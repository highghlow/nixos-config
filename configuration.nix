# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ./modules/root/bootloader.nix
      ./modules/root/network.nix
      ./modules/root/ssh.nix
      ./modules/root/tailscale.nix
      ./modules/root/locale.nix
      ./modules/root/user.nix
      ./modules/root/pipewire.nix
      ./modules/root/greetd.nix
      ./modules/root/fonts.nix
      ./modules/root/scripts.nix
    ];

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
