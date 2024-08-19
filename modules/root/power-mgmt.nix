{ config, lib, ... }:

{
  options = {
    mynixos.power-mgmt = {
      enable =
	lib.mkEnableOption "Enable module";
      battery-performance = lib.mkOption { default = 20; };
    };
  };

  config = lib.mkIf config.mynixos.power-mgmt.enable {
    services.power-profiles-daemon.enable = false;
    services.tlp = {
      enable = true;
      settings = {
	CPU_SCALING_GOVERNOR_ON_AC = "performance";
	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

	CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
	CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

	CPU_MIN_PERF_ON_AC = 0;
	CPU_MAX_PERF_ON_AC = 100;
	CPU_MIN_PERF_ON_BAT = 0;
	CPU_MAX_PERF_ON_BAT = config.mynixos.power-mgmt.battery-performance;
      };
    };
  };
}
