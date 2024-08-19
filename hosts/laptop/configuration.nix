{ config, ... }:

{
  imports =
    [
      ../../modules/root/all.nix
    ];

  mynixos = {
    bundle = {
      basic = {
        enable = true;
	bootloader = "grub";
	wireless = true;
	power-mgmt = true;
      };
      desktop = {
        enable = true;
	environment = "gnome";
      };
      remote-control.enable = true;
    };
    grub = {
      efi = true;
      removable = true;
    };
    user.passwordFile = config.age.secrets.user-password.path;
  };

  age.secrets.user-password.file = ./user-password.age;

  networking.hostName = "laptop";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
