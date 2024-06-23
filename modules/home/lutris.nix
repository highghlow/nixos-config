{ config, pkgs, ... }:

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
  home.packages = with pkgs; [
    (lutris.override {
       extraPkgs = pkgs: [
	 gtk3
       ];
    })
    wine
    wine64
    wine32
    winetricks
  ];
}
