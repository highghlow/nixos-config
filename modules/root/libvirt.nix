{ config, lib, pkgs, inputs, ... }:


{
  options = {
    mynixos.libvirt.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.libvirt.enable {
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

    virtualisation.libvirt.connections."qemu:///system".networks =
    [
      {
        definition = inputs.nixvirt.lib.network.writeXML (inputs.nixvirt.lib.network.templates.bridge {
	  uuid = "dd9132c8-0ea7-4848-a303-2ea1fc0d2201";
	  subnet_byte = 71;
	});
	active = true;
      }
    ];
  };
}
