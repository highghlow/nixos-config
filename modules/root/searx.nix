{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.searx.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.searx.enable {
    services.searx = {
      enable = true;

      settings = {
	server.port = 9998;
	server.bind_address = "127.0.0.1";
	server.secret_key = "noasecret";
      };

      package = pkgs.searxng;
    };
  };
}
