{ pkgs, conf, ... }:

{
  home._ = {
    home.sessionVariables = {
      BROWSER = "firefox";
    };
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      profiles.${conf.user.name} = {
        path = conf.user.name;
        settings = {
          "browser.fullscreen.autohide" = false;
        };
      };
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "firefox" ];
        "x-www-browser" = [ "firefox" ];
      };
    };
  };
}
