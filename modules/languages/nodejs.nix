{ pkgs, ... }:

{
  home._ = {
    home.pacakges = with pkgs;
      [
        nodejs
      ];

    programs.vscode.extensions = with pkgs;[ ];
  };
}
