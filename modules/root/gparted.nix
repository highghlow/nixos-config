{ config, pkgs, lib, ... }:

let gparted = let patched = (
  pkgs.gparted.overrideAttrs (old: {
    preFixup = ''
      gappsWrapperArgs+=(
         --prefix PATH : "${lib.makeBinPath (with pkgs;[ gpart hdparm util-linux procps coreutils gnused gnugrep mtools dosfstools exfatprogs])}"
      )
    '';
  })
); in pkgs.writeShellScriptBin "gparted" "sudo -E ${pkgs.gparted}/bin/gparted";
in
{
  options = {
    mynixos.gparted.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.gparted.enable {
    environment.systemPackages = with pkgs; [
      gparted

      exfat
      exfatprogs
      btrfs-progs
      e2fsprogs
      f2fs-tools
      dosfstools
      hfsprogs
      jfsutils
      mdadm
      util-linux
      nilfs-utils
      ntfsprogs
      reiser4progs
      udftools
      xfsprogs
    ];
  };
}
