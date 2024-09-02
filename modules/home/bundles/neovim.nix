{ config, lib, pkgs, ... }:

{
  options.mynixos.home.bundle.neovim = {
    enable = lib.mkEnableOption "the neovim home bundle";
    tmux = lib.mkOption { type = lib.types.bool; default = true; };
    ctrl-semicolon-bypass = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = let cfg = config.mynixos.home.bundle.neovim;
  in lib.mkIf cfg.enable
  {
    mynixos.home = {
      neovim.enable = true;
      tmux.enable = cfg.tmux;
      alacritty.ctrl-semicolon-bypass = cfg.ctrl-semicolon-bypass;
      gnome.ctrl-semicolon-bypass = cfg.ctrl-semicolon-bypass;
    };
  };
}
