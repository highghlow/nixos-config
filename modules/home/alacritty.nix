{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = lib.mkForce "Hack Nerd Font Mono";
      keyboard.bindings = [ 
	{
	  key = ";";
	  mods = "Control";
	  chars = "\\u7777";
	}
      ];
    };
  };
}
