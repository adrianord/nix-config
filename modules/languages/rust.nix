{ pkgs, ... }:

{
  imports = [
    ./toml.nix
  ];
  home._ = {
    home.packages = with pkgs; [
      cargo
      clippy
      rust-analyzer
      rustc
      rustfmt
    ];

    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        serayuzgur.crates
      ];

      userSettings = {
        rust-analyzer = {
          inlayHints = {
            parameterHints.enable = false;
            typeHints.enable = false;
            chainingHints.enable = false;
            closingBraceHints.enable = false;
          };
        };
      };
    };
  };
}
