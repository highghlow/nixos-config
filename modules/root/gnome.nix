{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.gnome.enable =
      lib.mkEnableOption "Enable module";
    mynixos.gnome.autologin =
      lib.mkEnableOption "autologin";
  };

  config = lib.mkIf config.mynixos.gnome.enable {
    programs.ydotool.enable = true;
    users.users.nixer.extraGroups = ["ydotool"];

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    services.displayManager.autoLogin = {
      enable = config.mynixos.gnome.autologin;
      user = "nixer";
    };

    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];

    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gedit # text editor
      cheese # webcam tool
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      yelp # help app
    ]) ++ (with pkgs.gnome; [
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

    services.xserver.excludePackages = [ pkgs.xterm ];
  };
}
