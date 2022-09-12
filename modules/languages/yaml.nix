{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs; [
      yq-go
    ];

    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        redhat.vscode-yaml
      ];
      userSettings = {
        redhat.telemetry.enabled = false;
        "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
      };
    };
  };
}
