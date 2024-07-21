{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.user.enable =
      lib.mkEnableOption "Enable module";
    mynixos.user.password = lib.mkOption { default = null; type = lib.types.str; };
  };

  config = lib.mkIf config.mynixos.user.enable {
    users.users.nixer = {
      isNormalUser = true;
      description = "nixer";
      extraGroups = [ "networkmanager" "wheel" "dialout" ];
      password = (if config.mynixos.user.password != "" then config.mynixos.user.password else null);
      packages = [];
    };
    security.pam.services.swaylock = {};
  };
}
