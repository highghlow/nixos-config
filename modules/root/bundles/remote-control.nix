{ config, lib, ... }:

{
  options.mynixos.bundle.remote-control = {
    enable = lib.mkEnableOption "the remote-control bundle";
    tailscale = lib.mkEnableOption "tailscale";
  };

  config = let cfg = config.mynixos.bundle.remote-control;
  in lib.mkIf cfg.enable
  {
    mynixos = {
      network.enable = true;
      ssh.enable = true;
      tailscale.enable = cfg.tailscale;
    };
  };
}
