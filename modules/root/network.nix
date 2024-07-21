{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.network.enable =
      lib.mkEnableOption "Enable module";
    mynixos.network.wireless =
      lib.mkEnableOption "Enable wireless";
  };

  config = let cfg = config.mynixos.network;
  in lib.mkIf cfg.enable (lib.mkMerge [
    {
      networking.networkmanager.enable = true;
      networking.firewall = {
	enable = true;
	allowedTCPPortRanges = [ 
	  { from = 5900; to = 5999; }
	];
      };
    }
    (lib.mkIf cfg.wireless {
      networking.wireless.iwd.enable = true;
    })
  ]);
}
