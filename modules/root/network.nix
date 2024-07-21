{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.network.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.network.enable {
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [ 
	{ from = 5900; to = 5999; }
      ];
    };
  };
}
