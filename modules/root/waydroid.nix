{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.waydroid.enable =
      lib.mkEnableOption "waydroid";
  };

  config = lib.mkIf config.mynixos.waydroid.enable {
    virtualisation.waydroid.enable = true;
  };
}
