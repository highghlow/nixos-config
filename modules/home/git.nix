{ lib, config, pkgs, ...}:

{
  options = {
    mynixos.home.git = {
      enable =
	lib.mkEnableOption "Enable module";
      lazygit = lib.mkOption { type = lib.types.bool; default = true; };
    };
  };

  config = let cfg = config.mynixos.home.git; in
  lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.git = {
	enable = true;
	userName = "highghlow";
	userEmail = "highghlow@proton.me";
	extraConfig = {
	  init.defaultBranch = "main";
	  pull.rebase = true;
	};
      };
    }
    (lib.mkIf cfg.lazygit {
      programs.lazygit = {
        enable = true;
	settings = {
	  git.disableForcePushing = true;
	  keybinding.universal = {
	    prevBlock-alt = "j";
	    nextItem-alt = "k";
	    prevItem-alt = "l";
	    nextBlock-alt = ";";

	    # scrollLeft = "J";
	    # scrollRight = ":";
	  };
	};
      };
    })
  ]);
}
