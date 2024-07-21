{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.fonts.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.fonts.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = ["Hack"]; })
      vistafonts
    ];
  };
}
