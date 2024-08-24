{config, lib, pkgs, ... }:

{
  options = {
    mynixos.sway.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.sway.enable {
    programs.sway.enable = true;

    xdg.portal.enable = true;
  };
}
