{lib, ...}: 

let umport = (import ../../libs/umport.nix { inherit lib; }).umport;
in {
  imports = umport {
    path = ./.;
    exclude = [ ./all.nix ];
  } ++ umport {
    path = ./bundles/.;
  };
}
