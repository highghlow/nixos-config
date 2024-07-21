{ config, lib, pkgs, ... }:

{
  options.mynixos.nixhelper = {
    enable =
      lib.mkEnableOption "Enable module";
    flake-path = lib.mkOption { default = "/home/nixer/nixos"; type = lib.types.str; };
  };

  config = lib.mkIf config.mynixos.nixhelper.enable {
    environment.sessionVariables = {
      FLAKE = "path://${config.mynixos.nixhelper.flake-path}";
    };

    environment.systemPackages = [ pkgs.nh ];
  };
}
