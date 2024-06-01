{ lib, config, pkgs, ...}:

{
  programs.git = {
    enable = true;
    userName = "highghlow";
    userEmail = "highghlow@proton.me";
  };
}
