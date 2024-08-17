{ config, lib, pkgs, ... }:

{
  options.mynixos.home.bundle.desktop = {
    enable = lib.mkEnableOption "the desktop home bundle";
    environment = lib.mkOption { default = "sway"; type = lib.types.enum ["sway" "gnome"]; };
  };

  config = let cfg = config.mynixos.home.bundle.desktop;
  in lib.mkIf cfg.enable
  {
    mynixos.home = {
      alacritty.enable = (cfg.environment == "sway");
      sway.enable = (cfg.environment == "sway");
      polkit-auth.enable = (cfg.environment == "sway");

      gnome.enable = (cfg.environment == "gnome");
      firefox.titlebar = lib.mkDefault (
        if cfg.environment == "gnome" then
	  true
	else
	  false
      );
    };
  };
}
