{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirt.enable = true; # NixVirt
  programs.virt-manager.enable = true;
  users.users.nixer.extraGroups = [ "libvirtd" ];
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
  environment.systemPackages = with pkgs; [ qemu ];

  systemd.services.libvirt-network = {
    description = "Enable virbr0 for libvirt";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "libvirt-network" ''
        if virsh net-info default | grep "Active:" | grep "yes"; then
	  ${pkgs.libvirt}/bin/virsh net-start default || true
	fi
      ''}";
    };
  };
}
