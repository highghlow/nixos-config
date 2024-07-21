{ lib, config, pkgs, ...}:

{
  options = {
    mynixos.home.git.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.git.enable {
    programs.git = {
      enable = true;
      userName = "highghlow";
      userEmail = "highghlow@proton.me";
      extraConfig = {
	init.defaultBranch = "main";
      };
    };
  };
}
