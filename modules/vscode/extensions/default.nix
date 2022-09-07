{ pkgs, ... }:

{
  imports = [
    ./errorlens.nix
  ];
  
  home._.programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      monokai.theme-monokai-pro-vscode
    ];
    userSettings = {
      workbench = {
        colorTheme = "Monokai Pro (Filter Octagon)";
        iconTheme = "Monokai Pro (Filter Octagon) Icons";
      };
    };
  };
}