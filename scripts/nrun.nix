with import <nixpkgs> {};

writeShellScriptBin "<script_name>" ''
nix-shell -p "$1" --run "$1"
''
