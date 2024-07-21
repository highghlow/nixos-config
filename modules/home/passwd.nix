{ lib, config, pkgs, ... }:

{
  options = {
    mynixos.home.passwd.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.passwd.enable {
    services.syncthing.enable = true;
    home.packages = with pkgs; [
      keepassxc
    ];
  };
}
