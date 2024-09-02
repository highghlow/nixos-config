{ config, pkgs, inputs, lib, ... }:

{
  imports = let umport = (import ../../../libs/umport.nix { inherit lib; }).umport;
  in (
    umport {
      path = ./plugins;
    }
  );

  options = {
    mynixos.home.neovim.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.neovim.enable {
    programs.nixvim.enable = true;

  };
}
