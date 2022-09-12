{ pkgs, ... }:

{
  imports = [
    ./errorlens.nix
  ];

  home._.programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      monokai.theme-monokai-pro-vscode
      Catppuccin.catppuccin-vsc
      streetsidesoftware.code-spell-checker
      PKief.material-icon-theme
    ];
    userSettings = {
      workbench = {
        colorTheme = "Catppuccin Mocha";
        iconTheme = "material-icon-theme";
      };
    };
  };
}
