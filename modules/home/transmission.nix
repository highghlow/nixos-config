{ pkgs, lib, config, ... }:

{
  options = {
    mynixos.home.transmission.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.transmission.enable {
    home.packages = with pkgs; [ transmission_4-qt ];
  };
}
