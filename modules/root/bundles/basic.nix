{ config, lib, pkgs, ... }:

{
  options.mynixos.bundle.basic = {
    enable = lib.mkEnableOption "the basic bundle";
    userPassword = lib.mkOption { default = ""; type = lib.types.str; };
    bootloader = lib.mkOption { default = null; type = lib.types.enum ["grub" "systemd-boot"]; };
    network = lib.mkOption { default = true; type = lib.types.bool; };
    wireless = lib.mkOption { default = false; type = lib.types.bool; };
    firewall = lib.mkOption { default = false; type = lib.types.bool; };
  };

  config = let cfg = config.mynixos.bundle.basic;
  in lib.mkIf cfg.enable
  {
    mynixos = {
      user = {
	enable = true;
	password = cfg.userPassword;
      };

      nixhelper.enable = true;
      locale.enable = true;
      zsh.enable = true;
      network.enable = lib.mkDefault cfg.network;
      network.wireless = cfg.wireless;
      network.firewall = cfg.firewall;
      systemd-boot.enable = cfg.bootloader == "systemd-boot";
      grub.enable = cfg.bootloader == "grub";
    };
  };
}
