{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (lutris.override {
       extraPkgs = pkgs: [
	 gtk3
       ];
    })
    wine
  ];
}
