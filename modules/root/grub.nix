{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.grub.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.grub.enable {
    boot.loader.grub.enable = true;
  };
}
