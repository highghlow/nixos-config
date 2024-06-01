{ config, pkgs, lib, ... }:

let patched-davinci = pkgs."davinci-resolve-studio".davinci.overrideAttrs  (old: {
    installPhase = old.installPhase + ''
      echo Davinci: $out
      pattern="\x55\x41\x56\x53\x48\x83\xEC\x20\x49\x89\xFE\x85\xF6\x0F\x84\x..\x81\xFE\x13\xFC\xFF\xFF\x0F\x85"
      offset=14
      file="$out/bin/resolve"
      # https://stackoverflow.com/a/17168777
      matches=$(LANG=C grep -obUaP "$pattern" "$file")
      matchcount=$(echo "$matches" | wc -l)
      if [[ -z $matches ]]; then
        echo "pattern not found";
	exit 1;
      elif [[ $matchcount -ne 1 ]]; then
        echo "pattern returned $matchcount matches instead of 1";
	exit 1;
      else
	patternOffset=$(echo $matches | cut -d: -f1)
	instructionOffset=$(($patternOffset + $offset))
	echo "patching byte '0x$(hexdump -s $instructionOffset -n 1 -e '/1 "%02x"' "$file")' at offset $instructionOffset"
	echo -en "\x85" | dd conv=notrunc of="$file" bs=1 seek=$instructionOffset count=1;
      fi
    '';
  });
in
{
  environment.systemPackages = [ patched-davinci ];
}
