{ lib, config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg = { enableTridactylNative = true; };
    };
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
          urls = [{ template = "https://startpage.com/search?q={searchTerms}"; }];
          iconUpdateUrl = "https://www.startpage.com/favicon.ico";
          updateInterval = 24 * 60 * 60 * 1000;
        };
        default = "Startpage";
        force = true;
      };
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
	"browser.toolbars.bookmarks.visibility" = "never";
      };
      extensions = with config.nur.repos.rycee.firefox-addons; [
        darkreader
	tridactyl
	sidebery
	sponsorblock
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
