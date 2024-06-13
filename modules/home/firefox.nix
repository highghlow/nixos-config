{ lib, config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      tridactyl-native
    ];
    policies = {
      DisablePocket = true;
      DisableAccounts = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      SearchBar = "separate";
      TranslateEnabled = false;
    };
   
    profiles.home-manager-configured = {
      isDefault = true;
      userChrome = ''
#TabsToolbar {
  visibility: collapse !important;
  margin-bottom: 21px !important;
}

#sidebar-box #sidebar-header {
  visibility: collapse !important;
}
      '';
      search = {
        engines."Startpage" = {
          urls = [{ template = "http://127.0.0.1:9998/search?q={searchTerms}"; }];
          iconUpdateUrl = "http://127.0.0.1:9998/favicon.ico";
          updateInterval = 24 * 60 * 60 * 1000;
        };
        default = "Startpage";
        force = true;
      };
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
	"browser.toolbars.bookmarks.visibility" = "never";
	"signon.rememberSignons" = false;
	"browser.startup.homepage" = "moz-extension://1e83d50e-56cd-42c9-a461-950048a88cdd/static/newtab.html";

	"privacy.history.custom" = true;
	"privacy.sanitize.sanitizeOnShutdown" = true;
	"privacy.clearOnShutdown.cookies" = false;
	"privacy.clearOnShutdown.sessions" = false;
      };
      extensions = with config.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
	tridactyl
	sidebery
	sponsorblock
      ];
      bookmarks = [
        {
	  name = "NixOS Package Search";
	  tags = [ "nixos" ];
	  keyword = ":np";
	  url = "https://search.nixos.org/packages";
	}
	{
	  name = "home-manager Options Search";
	  tags = [ "nixos" ];
	  keyword = ":hmo";
	  url = "https://home-manager-options.extranix.com";
	}
	{
	  name = "NUR Search";
	  tags = [ "nixos" ];
	  keyword = ":nur";
	  url = "https://nur.nix-community.org/";
	}
	{
	  name = "Youtube";
	  tags = [];
	  keyword = ":y";
	  url = "https://youtube.com";
	}
	{
	  name = "Github";
	  tags = [];
	  keyword = ":g";
	  url = "https://github.com";
	}
      ];
    };
  };

  home.file."${config.xdg.configHome}/tridactyl/tridactylrc".text = ''
    unbind h
    unbind j
    unbind k
    unbind l
    unbind ;;

    unbind H
    unbind J
    unbind K
    unbind L

    bind j scrollpx -50
    bind k scrollline 10
    bind l scrollline -10
    bind ; scrollpx 50

    bind <C-j> back
    bind K tabprev
    bind L tabnext
    bind <C-;> forward
  '';
}
