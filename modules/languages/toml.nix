{ pkgs, ... }:

{
  home._ = {

    programs.vscode.extensions = with pkgs; [
      vscode-extensions.bungcip.better-toml
    ];
  };
}
