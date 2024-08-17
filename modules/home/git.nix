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
	};
      };
    }
    (lib.mkIf cfg.lazygit {
      home.packages = [ pkgs.lazygit ];
    })
  ]);
}
