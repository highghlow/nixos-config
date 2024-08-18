{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.grub = {
      enable =
	lib.mkEnableOption "Enable module";
      efi =
        lib.mkEnableOption "EFI suport";
      removable =
        lib.mkEnableOption "removable suport";
    };
  };

  config = let cfg = config.mynixos.grub;
  in lib.mkIf cfg.enable (lib.mkMerge [
    {
      boot.loader.grub.enable = true;
    }

    (lib.mkIf cfg.efi {
      boot.loader.grub.efiSupport = true;
      boot.loader.grub.device = "nodev";
    })

    (lib.mkIf cfg.removable {
      boot.loader.grub.efiInstallAsRemovable = true;
    })
  ]);
}
