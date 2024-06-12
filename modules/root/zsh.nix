{ pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.nixer.shell = pkgs.zsh;
}
