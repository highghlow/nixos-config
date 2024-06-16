{ config, pkgs, ... }:

let wine = pkgs.linkFarm "wine" [ {
	     name = "bin/wine";
	     path = "${pkgs.wine64}/bin/wine64";
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
    winetricks
  ];
}
