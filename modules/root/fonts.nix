{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["Hack"]; })
    vistafonts
  ];
}
