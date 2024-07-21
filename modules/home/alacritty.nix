{ config, pkgs, lib, ... }:

{
  options.mynixos.home.alacritty = {
    enable =
      lib.mkEnableOption "Enable module";
    ctrl-semicolon-bypass = lib.mkOption { default = true; type = lib.types.bool; };
  };

  config = let cfg = config.mynixos.home.alacritty;
  in lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
	font.normal.family = lib.mkForce "Hack Nerd Font Mono";
	keyboard.bindings = if cfg.ctrl-semicolon-bypass then [ 
	  {
	    key = ";";
	    mods = "Control";
	    chars = "\\u7777";
	  }
	] else [];
      };
    };
  };
}
