{ lib, config, pkgs, ...}:

let screenshot = (pkgs.writeShellScript "sway-screenshot" ''
  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | tee /tmp/screenshot-`date +%d-%m-%YT%H:%M`.png | ${pkgs.wl-clipboard}/bin/wl-copy
'');
in
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";

      left = "j";
      down = "k";
      up = "l";
      right = "semicolon";
      
      menu = "${pkgs.bemenu}/bin/bemenu-run -H 24 --no-exec | xargs swaymsg exec --";     
 
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          conf = config.wayland.windowManager.sway.config;
        in lib.mkOptionDefault {
          "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "Menu" = "exec ${conf.menu}";
	  "Print" = "exec ${screenshot}";
        };
      
      bars = [
        { command = "${pkgs.waybar}/bin/waybar"; }
      ];
 
      input = {
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:alt_shift_toggle,caps:escape";
        };
      };
    };
  };
 
  programs.bemenu = { enable = true; };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        positiion = "top";
        
        modules-left = [ "sway/workspaces" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "custom/autolock-status" "custom/netcheck" "network#wifi" "network#ethernet" "network#disconnected" "pulseaudio" "memory" "cpu" "battery" "custom/date" "clock" "custom/uname" ];
  
        "cpu" = {
          format = "CPU: {usage}%";
        };

        "memory" = {
          format = "RAM: {used:0.1f}G/{total:0.1f}G ({percentage}%)";
          states = {
            "warning" = 70;
            "critical" = 90;
          };
        };

        "battery" = {
          format = "BAT: {capacity}%";
          format-charging = "CHR: {capacity}%";
          format-plugged = "PLG: {capacity}%";
        };

        "network#ethernet" = {
          interface = "enp*";
          format-ethernet = "ETHER";
          format-wifi = "";
          format-disconnected = "";
          format-linked = "";
        };

        "network#wifi" = {
          interface = "wlp*";
          format-ethernet = "";
          format-wifi = "WIFI = {essid} ({signalStrength}%)";
          format-disconnected = "";
        };

        "network#disconnected" = {
          format-ethernet = "";
          format-wifi = "";
          format-disconnected = "NOCON";
        };

        "pulseaudio" = {
          format = "VOL: {volume}%";
          format-muted = "MUT: {volume}%";
        };

        "clock" = {
          format = "{:%H(%I):%M}";
        };

        "custom/autolock-status" = {
          format = "{}";
          return-type = "json";
          exec = pkgs.writeShellScript "waybar-autolock-status" ''
            while true; do
              if ps -e | grep swayidle > /dev/null; then
                echo '{"text": "LCK: active", "class": ["alock-active", "alock-status"]}'
              else
                echo '{"text": "LCK: stopped", "class": ["alock-stopped", "alock-status"]}'
              fi
              sleep 1
            done;
          '';
        };

        "custom/date" = {
          format = "{}";
          return-type = "json";
          exec = pkgs.writeShellScript "waybar-date" ''
            while true; do
              echo "{\"text\": \"`date \"+%u-%a %d-%m(%h)-%Y\"`\", \"class\":[\"date\"]}"
              sleep 2600
            done
          '';
        };

        "custom/netcheck" = {
          format = "{}";
          return-type = "json";
          exec = pkgs.writeShellScript "waybar-netcheck" ''
            while true; do
              if ping example.com -c 1 > /dev/null 2> /dev/null; then
                echo '{"text": "NET: success", "class": ["netcheck-success", "netcheck"]}'
              else
                echo '{"text": "NET: error", "class": ["netcheck-error", "netcheck"]}'
              fi
              sleep 5
           done
         '';
        };

        "custom/uname" = {
          format = "{}";
          return-type = "json";
          exec = pkgs.writeShellScript "waybar-uname" ''
            while true; do
              echo "{\"text\": \"`uname -r`\", \"class\":[\"uname\"]}"
              sleep 3600
            done
          '';
        };
      };
    };

    style = ''
@define-color bg-normal transparent;
@define-color bg-warning #9e824c;
@define-color bg-critical #f53c3c;

* {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 13px;
}

window#waybar {
    background-color: rgba(43, 48, 59, 0.5);
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

button {
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
    /* Avoid rounded borders under each button name */
    border: none;
    border-radius: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #ffffff;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
}

#workspaces button.focused {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    border-bottom: 3px solid #ffffff;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
}

.alock-status, .date, .netcheck, .uname,
#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#mpd {
	padding: 0 10px;
	color: #ffffff;
	background-color: @bg-normal;
}

#memory.warning,
#tray > .needs-attention,
#pulseaudio.muted,
#wireplumber.muted,
#mpd.disconnected {
	background-color: @bg-warning;
}

.alock-stopped,
.netcheck-error,
#battery.critical:not(.charging),
#network.disconnected,
#memory.critical,
#battery.critical:not(.charging)
{
	background-color: @bg-critical;
}
'';
  };
}
