{ pkgs, ... }:

{
  imports = [
    ./dotnet.nix
    ./python.nix
  ];
  home._ = {
    home.packages = with pkgs; [
      nixpkgs-fmt
      rnix-lsp

      nodejs


      vale
    ];
    programs = {
      go = {
        enable = true;
        package = pkgs.go_1_19;
      };
    };
  };
}
