{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.wilder.enable = true;
  };
}
