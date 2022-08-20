{ pkgs, conf, lib, ... }:

{
  home._ = {
    home.sessionVariables = {
      BROWSER = "firefox";
    };
    programs.firefox = lib.mkIf (conf.host.os == "linux") {
      enable = true;
      package = pkgs.firefox-wayland;
      profiles.${conf.user.name} = {
        path = conf.user.name;
        settings = {
          "browser.fullscreen.autohide" = false;
        };
      };
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
