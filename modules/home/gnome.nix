
{ lib, config, pkgs, ...}:

{
  options = {
    mynixos.home.gnome = {
      enable =
	lib.mkEnableOption "Enable module";
      ctrl-semicolon-bypass =
	lib.mkOption { default = true; type = lib.types.bool; };
    };
  };

  config = let cnf = config.mynixos.home.gnome; in lib.mkIf cnf.enable {
    home.packages = [ pkgs.wl-clipboard ];

    dconf = {
      enable = true;
      settings = lib.mkMerge [
	{
	  "org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
	  "org/gnome/desktop/input-sources".xkb-options = ["terminate:ctrl_alt_bksp" "lv3:ralt_switch" "caps:escape" "grp:alt_shift_toggle"];

	  "org/gnome/Console".use-system-font = false;
	  "org/gnome/Console".custom-font = "Hack Nerd Font Mono 12";

	  "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
	  "org/gnome/settings-daemon/plugins/power".power-button-action = "interactive";

	  "org/gnome/mutter".edge-tiling = true;
	  "org/gnome/mutter".dynamic-workspaces = true;

	  "org/gnome/desktop/input-sources".sources = [(lib.hm.gvariant.mkTuple ["xkb" "us"]) (lib.hm.gvariant.mkTuple ["xkb" "ru"])];

	  "org/gnome/desktop/interface".cursor-theme = lib.mkForce "Adwaita";

	  "org/gnome/desktop/wm/preferences".focus-mode = "sloppy";

	  "org/gnome/shell".disable-user-extensions = false;
	  "org/gnome/shell".enabled-extensions = ["launch-new-instance@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "system-monitor@gnome-shell-extensions.gcampax.github.com"];
	}

	(lib.mkIf cnf.ctrl-semicolon-bypass {
	  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
	    name = "Ctrl-; bypass";
	    command = "ydotool key 29:1 25:1 25:0 29:0"; # Ctrl-P
	    binding = "<Control>semicolon";
	  };
	})
      ];
    };
  };
}
