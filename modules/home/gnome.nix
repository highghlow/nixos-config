
{ lib, config, pkgs, ...}:

{
  options = {
    mynixos.home.gnome.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.gnome.enable {
    dconf = {
      enable = true;
      settings = {
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
      };
    };
  };
}
