{ config, lib, pkgs, ... }:

{
  options.mynixos.bundle.desktop = {
    enable = lib.mkEnableOption "the desktop bundle";
    bluetooth = lib.mkEnableOption "bluetooth";
    autologin = lib.mkEnableOption "autologin";
    environment = lib.mkOption { default = null; type = lib.types.enum ["sway" "gnome"]; };
  };

  config = let cfg = config.mynixos.bundle.desktop;
  in lib.mkIf cfg.enable
  {
    mynixos = {
      bluetooth.enable = cfg.bluetooth;
      fonts.enable = true;

      gnome = {
        enable = cfg.environment == "gnome";
	autologin = cfg.autologin;
      };

      greetd = {
        enable = cfg.environment == "sway";
	autologin = cfg.autologin;
	defaultSession = "${pkgs.sway}/bin/sway";
      };
      sway.enable = cfg.environment == "sway";
      pipewire.enable = cfg.environment == "sway";
    };
  };
}
