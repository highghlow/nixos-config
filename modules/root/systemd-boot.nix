{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.systemd-boot.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
