{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.gnome.enable =
      lib.mkEnableOption "Enable module";
    mynixos.gnome.autologin =
      lib.mkEnableOption "autologin";
  };

  config = lib.mkIf config.mynixos.gnome.enable {
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
    ]) ++ (with pkgs.gnome; [
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  };
}
