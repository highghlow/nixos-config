{ pkgs, lib, ... }:

let
  nrun = pkgs.writeShellScriptBin "nrun" ''
    export NIXPKGS_ALLOW_UNFREE=1
    nix-shell -p "$(echo $*|cut -d ' ' -f1|tr '\n' ' ')" --run "$*"
  '';
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
  environment.systemPackages = [ nrun edit-nix-config ];
}
