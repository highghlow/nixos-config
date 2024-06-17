{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirt.enable = true; # NixVirt
  programs.virt-manager.enable = true;
  users.users.nixer.extraGroups = [ "libvirtd" ];
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
  environment.systemPackages = with pkgs; [ qemu ];
}
