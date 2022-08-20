{ pkgs, ... }:

{
  home._.programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };
}
