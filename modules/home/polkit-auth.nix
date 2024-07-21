{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.home.polkit-auth.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.polkit-auth.enable {
    systemd.user.services.sway-polkit-authentication-agent = {
      Unit = {
	Description = "Sway Polkit authentication agent";
	Documentation = "https://gitlab.freedesktop.org/polkit/polkit/";
	After = [ "graphical-session-pre.target" ];
	PartOf = [ "graphical-session.target" ];
      };

      Service = {
	Type = "simple";
	ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	Restart = "always";
	BusName = "org.freedesktop.PolicyKit1.Authority";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
