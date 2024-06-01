{ lib, config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
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
/* Hide tab bar */
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
      extensions = with config.nur.repos.rycee.firefox-addons; [
        darkreader
	tridactyl
	sidebery
      ];
    };
  };
}
