{ pkgs, ... }:

{
  imports = [
    ./userSettings.nix
    ./keybindings.nix
    ./extensions
  ];
  home._.programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs; [
        vscode-extensions.asvetliakov.vscode-neovim
      ];
      userSettings = {
        vscode-neovim.neovimExecutablePaths.darwin = "nvim";
      };
    };
    zsh = {
      shellAliases = {
      };
    };
  };
}
