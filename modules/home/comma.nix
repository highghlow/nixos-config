{ pkgs, lib, config, ... }:

{
  options = {
    mynixos.home.comma.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.comma.enable {
    home.packages = [ pkgs.comma ]; 
  };
}
