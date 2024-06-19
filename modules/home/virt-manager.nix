{ config, pkgs, inputs, ... }:

let vm = pkgs.linkFarm "vm" [ {
	     name = "bin/vm";
	     path = "${pkgs.virt-manager}/bin/virt-manager";
	   } ];
in
{
  home.packages = with pkgs; [ virt-manager vm ];
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///session"];
      uris = ["qemu:///session"];
    };
  };

  virtualisation.libvirt = {
    enable = true;
    swtpm.enable = true;
  };
  virtualisation.libvirt.connections."qemu:///session".domains =
  [
    {
      definition = inputs.nixvirt.lib.domain.writeXML (inputs.nixvirt.lib.domain.templates.windows
        {
          name = "Windows 11";
          uuid = "096aad10-8e34-4db8-9899-6d801c2ec7fd";
          memory = { count = 16; unit = "GiB"; };
          storage_vol = { pool = "default"; volume = "win11.qcow2"; };
	  install_vol = /home/nixer/.local/share/libvirt/isos/win11.iso;
	  nvram_path = /home/nixer/.local/share/libvirt/nvram/win11.nvram;
        });
    }
  ];
}
