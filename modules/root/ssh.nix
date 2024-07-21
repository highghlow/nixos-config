{ lib, config, pkgs, ... }:

{
  options = {
    mynixos.ssh.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.ssh.enable {
    services.openssh = {
      enable = true;
      # settings.PasswordAuthentication = false;
    };
  };
}
