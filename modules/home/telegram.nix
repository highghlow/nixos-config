{ pkgs, lib, config, ... }:

{
  options = {
    mynixos.home.telegram.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.telegram.enable {
    home.packages = [ pkgs.telegram-desktop ];
  };
}
