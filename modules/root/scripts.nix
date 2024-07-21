{ pkgs, config, lib, ... }:

let
  edit-nix-config = pkgs.writeShellScriptBin "edit-nix-config" ''
    set -e
    pushd ~/nixos
    nvim .
    git diff -U0 *.nix
    echo "Rebuilding..."
    sudo rm -r /etc/nixos/* || true
    sudo cp -r ~/nixos/* /etc/nixos
    sudo nixos-rebuild switch &> nixos-switch.log || ( cat nixos-switch.log | grep --color error && false )
    gen=$(nixos-rebuild list-generations | grep current)
    git add .
    git commit -m "$gen"
    popd
  '';
in {
  options = {
    mynixos.scripts.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.scripts.enable {
    environment.systemPackages = [ edit-nix-config ];
  };
}
