{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.docker.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.docker.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
	enable = true;
	setSocketVariable = true;
      };
    };
  };
}
