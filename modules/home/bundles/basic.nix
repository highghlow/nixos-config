{ config, lib, pkgs, ... }:

{
  options.mynixos.home.bundle.basic = {
    enable = lib.mkEnableOption "the basic home bundle";
  };

  config = let cfg = config.mynixos.home.bundle.basic;
  in lib.mkIf cfg.enable
  {
    mynixos.home = {
      git.enable = true;
      zsh.enable = true;
      comma.enable = true;
    };
  };
}
