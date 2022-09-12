{ pkgs, ... }:

{
  home._ = {
    programs = {
      go = {
        enable = true;
        package = pkgs.go_1_19;
      };
      vscode = {
        extensions = with pkgs.vscode-extensions; [
          golang.go
        ];
      };
    };
  };
}
