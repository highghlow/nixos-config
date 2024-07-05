{ pkgs, ... }:

{
  environment.sessionVariables = {
    FLAKE = "path:///home/nixer/nixos";
  };

  environment.systemPackages = [ pkgs.nh ];
}
