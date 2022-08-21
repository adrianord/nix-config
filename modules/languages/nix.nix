{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs; [
      nixpkgs-fmt
      rnix-lsp
    ];
  };
}
