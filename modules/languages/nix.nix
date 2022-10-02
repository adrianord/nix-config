{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs; [
      nixpkgs-fmt
      rnix-lsp
      nil
    ];
    programs.vscode = {
      extensions = with pkgs; [
        vscode-extensions.bbenoist.nix
        vscode-extensions.jnoortheen.nix-ide
      ];
      userSettings.nix = {
        enableLanguageServer = true;
        serverPath = "nil";
      };
    };
  };
}
