{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.pipewire.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
