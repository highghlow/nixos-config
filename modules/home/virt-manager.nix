{ config, pkgs, inputs, lib, ... }:

let vm = pkgs.linkFarm "vm" [ {
	     name = "bin/vm";
	     path = "${pkgs.virt-manager}/bin/virt-manager";
	   } ];
in
{
  options = {
    mynixos.home.virt-manager.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.virt-manager.enable {
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
	    install_virtio = true;
	  } // {
	    vcpu.count = 6;
	    filesystem  = {
	      driver = { type = "virtiofs"; queue=1024; };
	      source.dir = "/home/nixer/.local/share/libvirt/shared/win11";
	      target.dir = "shared";
	    };
	  } );
      }
      {
	definition = inputs.nixvirt.lib.domain.writeXML (inputs.nixvirt.lib.domain.templates.pc
	  {
	    name = "Windows 7";
	    uuid = "b1b057d1-708b-4b48-bb5f-8d7e998390b9";
	    memory = { count = 16; unit = "GiB"; };
	    storage_vol = { pool = "default"; volume = "win7.qcow2"; };
	    install_vol = /home/nixer/.local/share/libvirt/isos/win7.iso;
	    virtio_drive = false;
	  });
      }
      {
	definition = inputs.nixvirt.lib.domain.writeXML {
	  name = "Mac OS";
	  type = "kvm";
	  uuid = "2aca0dd6-cec9-4717-9ab2-0b7b13d111c3";
	  title = "macOS";
	  memory = { count = 4194304; unit = "KiB"; };
	  currentMemory = { count = 4194304; unit = "KiB"; };
	  vcpu = { placement = "static"; count = 4; };
	  cpu = {
	    mode = "custom";
	    match = "exact";
	    check = "none";
	    model = { fallback = "forbid"; name = "qemu64"; };
	  };
	  os = {
	    type = "hvm";
	    arch = "x86_64";
	    machine = "pc-q35-4.2";
	    loader = {
	      readonly = true;
	      type = "pflash";
	      path = "/home/nixer/.local/share/libvirt/nvram/macos_code.fd";
	    };
	    nvram.path = "/home/nixer/.local/share/libvirt/nvram/macos_vars.fd";
	  };

	  features = {
	    acpi = { };
	    apic = { };
	  };

	  clock = {
	    offset = "utc";
	    timer =
	      [
		{ name = "rtc"; tickpolicy = "catchup"; }
		{ name = "pit"; tickpolicy = "delay"; }
		{ name = "hpet"; present = false; }
	      ];
	  };

	    
	  on_poweroff = "destroy";
	  on_reboot = "restart";
	  on_crash = "restart";

	  devices = let
	    pcie_root_port = index: mf: {
	      type = "pci";
	      inherit index;
	      model = "pcie-root-port";
	      target = { chassis = index; port = index + 7; };
	      address = { type = "pci"; domain = 0; slot = 1; function = index - 1; multifunction = mf; };
	    };
	  in {
	    emulator = "${pkgs.qemu}/bin/qemu-system-x86_64";
	    disk = [
	      {
		driver = { name = "qemu"; type = "qcow2"; cache = "writeback"; io = "threads"; };
		source.file = "/home/nixer/.local/share/libvirt/images/macos_opencore.qcow2";
		target = { bus = "sata"; dev = "sda"; };
		address = { type = "drive"; controller = 0; bus = 0; target = 0; unit = 0; };
		boot.order = 2;
	      }
	      {
		driver = { name = "qemu"; type = "qcow2"; cache = "writeback"; io = "threads"; };
		source.file = "/home/nixer/.local/share/libvirt/images/macos_hdd_ng.img";
		target = { bus = "sata"; dev = "sdb"; };
		address = { type = "drive"; controller = 0; bus = 0; target = 0; unit = 1; };
		boot.order = 1;
	      }
	      {
		driver = { name = "qemu"; type = "raw"; cache = "writeback"; };
		source.file = "/home/nixer/.local/share/libvirt/images/macos_base_system.img";
		target = { bus = "sata"; dev = "sdc"; };
		address = { type = "drive"; controller = 0; bus = 0; target = 0; unit = 2; };
		boot.order = 3;
	      }
	    ];
	    controller = [
	      {
		type = "sata";
		index = 0;
		address = { type = "pci"; domain = 0; bus = 0; slot = 31; function = 2; };
	      }
	      {
		type = "pci";
		index = 0;
		model = "pcie-root";
	      }
	      (pcie_root_port 1 true) 
	      (pcie_root_port 2 null) 
	      (pcie_root_port 3 null) 
	      (pcie_root_port 4 null)
	      (pcie_root_port 5 null)
	      (pcie_root_port 6 null)
	      (pcie_root_port 7 null)
	      {
		type = "virtio-serial";
		index = 0;
		address = { type = "pci"; domain = 0; bus = 2; slot = 0; function = 0; };
	      }
	      {
		type = "usb";
		index = 0;
		model = "ich9-ehci1";
		address = { type = "pci"; domain = 0; bus = 0; slot = 7; function = 7; };
	      }
	      {
		type = "usb";
		index = 0;
		model = "ich9-uhci1";
		master.startport = 0;
		address = { type = "pci"; domain = 0; bus = 0; slot = 7; function = 0; multifunction = true; };
	      }
	      {
		type = "usb";
		index = 0;
		model = "ich9-uhci2";
		master.startport = 2;
		address = { type = "pci"; domain = 0; bus = 0; slot = 7; function = 1; };
	      }
	      {
		type = "usb";
		index = 0;
		model = "ich9-uhci3";
		master.startport = 4;
		address = { type = "pci"; domain = 0; bus = 0; slot = 7; function = 2; };
	      }
	    ];
	    interface = [
	      {
		type = "bridge";
		mac.address = "52:54:00:e6:85:40";
		source.bridge = "virbr0";
		model.type = "vmxnet3";
		address = { type = "pci"; domain = 0; bus = 0; slot = 0; function = 0; };
	      }
	    ];
	    serial = [
	      {
	       type = "pty";
		target = {
		  type = "isa-serial";
		  port = 0;
		  model.name = "isa-serial";
		};
	      }

	    ];
	    channel = [
	      {
		type = "unix";
		target = { type = "virtio"; name = "org.qemu.guest_agent.0"; };
		address = { type = "virtio-serial"; controller = 0; bus = 0; port = 1; };
	      }
	    ];
	    graphics = [
	      {
		type = "spice";
		autoport = true;
		listen.type = "address";
	      }
	    ];
	    video = [
	      {
		model = { type = "virtio"; heads = 1; primary = true; };
	      }
	    ];
	  };

	  qemu-commandline.arg = [
	    { value = "-device"; }
	    { value = "isa-applesmc,osk=ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"; }
	    { value = "-smbios"; }
	    { value = "type=2"; }
	    { value = "-usb"; }
	    { value = "-device"; }
	    { value = "usb-tablet"; }
	    { value = "-device"; }
	    { value = "usb-kbd"; }
	    { value = "-cpu"; }
	    { value = "Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"; }
	  ];
	};
      }

    ];
  };
}
