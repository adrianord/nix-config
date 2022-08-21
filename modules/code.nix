{ pkgs, ... }:

let

in
{
  home._.programs.vscode = {
    enable = true;
    package = pkgs.vscodeInsiders;
  };
}
