{ config, lib, pkgs, ... }:

{
  options.mynixos.home.bundle.apps = {
    all = lib.mkEnableOption "all apps";
    communication = lib.mkEnableOption "communication apps";
    games = lib.mkEnableOption "games";
    passwd = lib.mkEnableOption "the password manager";
    vm = lib.mkEnableOption "virtual machines";
    transmission = lib.mkEnableOption "transmission";
    firefox = lib.mkEnableOption "firefox";
    davinci-resolve = lib.mkEnableOption "Davinci Resolve";
    obsidian = lib.mkEnableOption "obsidian";
    gimp = lib.mkEnableOption "gimp";
    libreoffice = lib.mkEnableOption "libreoffice";
    mpv = lib.mkEnableOption "mpv";
    unity = lib.mkEnableOption "unity";
    localsend = lib.mkEnableOption "localsend";
  };

  config = let cfg = config.mynixos.home.bundle.apps;
  in {
    mynixos.home = {
      telegram.enable = cfg.communication || cfg.all;
      discord.enable = cfg.communication || cfg.all;

      games.enable = cfg.games || cfg.all;

      passwd.enable = cfg.passwd || cfg.all;

      transmission.enable = cfg.transmission || cfg.all;

      virt-manager.enable = cfg.vm || cfg.all;

      firefox.enable = cfg.firefox || cfg.all;

      davinci-resolve.enable = cfg.davinci-resolve || cfg.all;
    };

    home = 
    let pkg = cond: package: lib.mkIf (cond || cfg.all) {
      packages = [ package ];
    }; in lib.mkMerge [
      (pkg cfg.obsidian pkgs.obsidian)
      (pkg cfg.gimp pkgs.gimp)
      (pkg cfg.libreoffice pkgs.libreoffice-fresh)
      (pkg cfg.unity pkgs.unityhub)
      (pkg cfg.mpv pkgs.mpv)
      (pkg cfg.localsend pkgs.localsend)
    ];
  };
}
