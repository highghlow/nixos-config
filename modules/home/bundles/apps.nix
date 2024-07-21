{ config, lib, pkgs, ... }:

{
  options.mynixos.home.bundle.apps = {
    communication = lib.mkEnableOption "communication apps";
    games = lib.mkEnableOption "games";
    passwd = lib.mkEnableOption "the password manager";
    vm = lib.mkEnableOption "virtual machines";
    transmission = lib.mkEnableOption "transmission";
    firefox = lib.mkEnableOption "firefox";
  };

  config = let cfg = config.mynixos.home.bundle.apps;
  in {
    mynixos.home = {
      telegram.enable = cfg.communication;
      discord.enable = cfg.communication;

      games.enable = cfg.games;

      passwd.enable = cfg.passwd;

      transmission.enable = cfg.transmission;

      virt-manager.enable = cfg.vm;

      firefox.enable = cfg.firefox;
    };
  };
}
