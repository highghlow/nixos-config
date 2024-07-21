{ config, lib, pkgs, ... }:

{
  options.mynixos.greetd = {
    enable =
      lib.mkEnableOption "Enable module";
    autologin =
      lib.mkEnableOption "automatic login";
    defaultSession = lib.mkOption { type = lib.types.str; };
  };

  config = let cfg = config.mynixos.greetd;
  in lib.mkIf cfg.enable {
    hardware.opengl.enable = true;
    hardware.opengl.driSupport32Bit = true;
    services.greetd = lib.mkMerge [
      {
	enable = true;
      }

      (if cfg.autologin then {
	settings.default_session = {
	  command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
	};
	settings.initial_session = {
	  command = cfg.defaultSession;
	  user = "nixer";
	};
      } else {})
    ];
  };
}
