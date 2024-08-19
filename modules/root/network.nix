{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.network.enable =
      lib.mkEnableOption "Enable module";
    mynixos.network.wireless =
      lib.mkEnableOption "Enable wireless";
    mynixos.network.firewall =
      lib.mkEnableOption "firewall";
  };

  config = let cfg = config.mynixos.network;
  in lib.mkIf cfg.enable (lib.mkMerge [
    {
      networking.networkmanager.enable = true;
      networking.firewall = {
	enable = cfg.firewall;
	allowedTCPPortRanges = [ 
	  { from = 5900; to = 5999; }
	];
	allowedTCPPorts = [ 53317 ];
      };
    }
    (lib.mkIf cfg.wireless {
      networking = {
        wireless.iwd.enable = true;
	networkmanager.wifi.backend = "iwd";
      };
    })
  ]);
}
