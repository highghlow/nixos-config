{ lib, config, pkgs, ... }:

{
  options = {
    mynixos.tailscale.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.tailscale.enable {
    services.tailscale.enable = true;
  };
}
