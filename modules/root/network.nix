{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 5900; to = 5999; }
    ];
  };
}
