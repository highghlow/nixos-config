{ config, lib, pkgs, ... }:

{
  options = {
    mynixos.home.davinci-resolve.enable =
      lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf config.mynixos.home.davinci-resolve.enable (
    let patched-davinci =
      let davinci = pkgs."davinci-resolve-studio".davinci.overrideAttrs  (old: {
	installPhase = old.installPhase + ''
	  echo Patching Davinci Resolve...
	  echo Davinci: $out
	  pattern="\x55\x41\x56\x53\x48\x83\xEC\x20\x49\x89\xFE\x85\xF6\x0F\x84....\x81\xFE\x13\xFC\xFF\xFF\x0F\x85"
	  offset=14
	  file="$out/bin/resolve"
	  # https://stackoverflow.com/a/17168777

	  echo Searching for the pattern...

	  matches=$(LANG=C grep -obUaP "$pattern" "$file")
	  matchcount=$(echo "$matches" | wc -l)
	  if [[ -z $matches ]]; then
	    echo "pattern not found";
	    exit 1;
	  elif [[ $matchcount -ne 1 ]]; then
	    echo "pattern returned $matchcount matches instead of 1";
	    exit 1;
	  else
	    echo Pattern found! Patching...
	    patternOffset=$(echo $matches | cut -d: -f1)
	    instructionOffset=$(($patternOffset + $offset))
	    echo "patching byte '0x$(hexdump -s $instructionOffset -n 1 -e '/1 "%02x"' "$file")' at offset $instructionOffset"
	    echo -en "\x85" | dd conv=notrunc of="$file" bs=1 seek=$instructionOffset count=1;
	    echo Patch successful
	  fi
	'';
      }); in pkgs.buildFHSEnv {
	inherit (pkgs."davinci-resolve-studio") version meta;
	pname = "patched-davinci";

	targetPkgs = pkgs: with pkgs; [
	  alsa-lib
	  aprutil
	  bzip2
	  davinci
	  dbus
	  expat
	  fontconfig
	  freetype
	  glib
	  libGL
	  libGLU
	  libarchive
	  libcap
	  librsvg
	  libtool
	  libuuid
	  libxcrypt # provides libcrypt.so.1
	  libxkbcommon
	  nspr
	  ocl-icd
	  opencl-headers
	  python3
	  python3.pkgs.numpy
	  udev
	  xdg-utils # xdg-open needed to open URLs
	  xorg.libICE
	  xorg.libSM
	  xorg.libX11
	  xorg.libXcomposite
	  xorg.libXcursor
	  xorg.libXdamage
	  xorg.libXext
	  xorg.libXfixes
	  xorg.libXi
	  xorg.libXinerama
	  xorg.libXrandr
	  xorg.libXrender
	  xorg.libXt
	  xorg.libXtst
	  xorg.libXxf86vm
	  xorg.libxcb
	  xorg.xcbutil
	  xorg.xcbutilimage
	  xorg.xcbutilkeysyms
	  xorg.xcbutilrenderutil
	  xorg.xcbutilwm
	  xorg.xkeyboardconfig
	  zlib
	];

	extraPreBwrapCmds = ''
	  mkdir -p ~/.local/share/DaVinciResolve/license || exit 1
	'';

	extraBwrapArgs = [
	  "--bind \"$HOME\"/.local/share/DaVinciResolve/license ${davinci}/.license"
	];


	runScript = "${pkgs.bash}/bin/bash ${
	  pkgs.writeText "davinci-wrapper"
	  ''
	  export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
	  export QT_PLUGIN_PATH="${davinci}/libs/plugins:$QT_PLUGIN_PATH"
	  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:${davinci}/libs
	  ${davinci}/bin/resolve
	  ''
	}";

	passthru = {
	  inherit davinci;
	};
      };
    in
    {
      home.packages = [ patched-davinci pkgs.audacity ];

      xdg.desktopEntries = {
	davinci-resolve = {
          name = "Davinci Resolve";
          genericName = "Video Editor";
          icon = ./images/davinci-resolve-icon.tif;
          comment = "Professional video editing, color, effects and audio post-processing";
          categories = [
            "AudioVideo"
            "AudioVideoEditing"
            "Video"
            "Graphics"
          ];
          exec = "patched-davinci";
        };
      };
    }
  );
}
