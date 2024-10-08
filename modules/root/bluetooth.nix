{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.bluetooth.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    services.pipewire.wireplumber.extraConfig = {
      "monitor.bluez.properties" = {
	  "bluez5.enable-sbc-xq" = true;
	  "bluez5.enable-msbc" = true;
	  "bluez5.enable-hw-volume" = true;
	  "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      };
    };
    environment.systemPackages = with pkgs; [ pavucontrol ];
  };
}
