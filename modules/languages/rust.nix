{ pkgs, ... }:

{
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
    };
  };
}
