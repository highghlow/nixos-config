{ pkgs, ... }:

{
  home.packages = with pkgs; [ transmission-qt ];
}
