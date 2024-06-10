{ config, pkgs, ... }:

{
  users.users.nixer = {
    isNormalUser = true;
    description = "nixer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  security.pam.services.swaylock = {};
}
