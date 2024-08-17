# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/root/all.nix
    ];

  mynixos = {
    bundle = {
      basic = {
        enable = true;
	bootloader = "systemd-boot";
      };
      remote-control.enable = true;
      desktop = {
        enable = true;
        environment = "gnome";
	bluetooth = true;
	autologin = true;
      };
    };

    docker.enable = true;
    libvirt.enable = true;
    searx.enable = true;
    gparted.enable = true;
    waydroid.enable = true;
  };

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  networking.hostName = "nixos";
  time.timeZone = "Europe/Moscow";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
    vim
  ];

  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
