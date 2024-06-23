{ config, pkgs, ... }:

{
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
    };
    settings.initial_session = {
      command = "${pkgs.sway}/bin/sway";
      user = "nixer";
    };
  };
}
