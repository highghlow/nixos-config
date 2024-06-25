{ pkgs, lib, ... }:

let forkgram = pkgs.telegram-desktop.overrideAttrs (old: rec {
  version = "5.1.7";
  src = pkgs.fetchFromGitHub {
    owner = "forkgram";
    repo = "tdesktop";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-OH9+cH5CQyrp4DSKXEMs6csGiH+GAtxJT4P9YidmAcM=";
  };
});
in
{
  home.packages = [ forkgram ];
}
