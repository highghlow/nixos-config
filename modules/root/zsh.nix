{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.zsh.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.zsh.enable {
    programs.zsh.enable = true;
    users.users.nixer.shell = pkgs.zsh;
  };
}
