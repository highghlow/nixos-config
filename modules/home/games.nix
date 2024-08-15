{ config, lib, pkgs, ... }:

let wine = pkgs.linkFarm "wine" [ {
	     name = "bin/wine";
	     path = "${pkgs.wine64}/bin/wine64";
	   } ];
    wine32 = pkgs.linkFarm "wine32" [ {
	     name = "bin/wine32";
	     path = "${pkgs.wine}/bin/wine";
	   } ];
in
{
  options = {
    mynixos.home.games.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.games.enable {
    home.packages = with pkgs; [
      (lutris.override {
	 extraPkgs = pkgs: [
	   gtk3
	 ];
      })
      wineWow64Packages.full
      wine32
      winetricks
      prismlauncher
    ];
  };
}
