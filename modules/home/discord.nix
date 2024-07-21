{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.home.discord.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.discord.enable {
    home.packages = [
	pkgs.vesktop
    ];
  };
}
