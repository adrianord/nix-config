{ pkgs, conf, lib, ... }:

{
  home._ = {
    home.sessionVariables = {
      BROWSER = "firefox";
    };
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
      profiles.${conf.user.name} = {
        isDefault = true;
        path = conf.user.name;
        settings = {
          "browser.fullscreen.autohide" = false;
          "browser.ctrlTab.sortByRecentlyUsed" = true;
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        vimium
        darkreader
      ];
    };
    xdg.mimeApps = lib.mkIf (conf.host.os == "linux") {
      enable = true;
      defaultApplications = {
        "text/html" = [ "firefox" ];
        "x-www-browser" = [ "firefox" ];
      };
    };
  };
}
