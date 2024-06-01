{ pkgs, lib, ... }:

{
  stylix.base16Scheme = {
    base00 = "181818";
    base01 = "404040";
    base02 = "505050";
    base03 = "b0b0b0";
    base04 = "d0d0d0";
    base05 = "e0e0e0";
    base06 = "f5f5f5";
    base07 = "ffffff";
    base08 = "cc6666";
    base09 = "cc9966";
    base0A = "f0c674";
    base0B = "6CBD68";
    base0C = "8abeb7";
    base0D = "81a2be";
    base0E = "b294bb";
    base0F = "cc9966";
  };

  stylix.fonts = {
    monospace = {
      package = (pkgs.nerdfonts.override { fonts = ["Hack"]; });
      name = "Hack";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.image = ./wallpaper.png;
}
