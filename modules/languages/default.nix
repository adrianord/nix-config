{ pkgs, ... }:

{
  imports = [
    ./dotnet.nix
    ./python.nix
  ];
  home._ = {
    home.packages = with pkgs; [
      nixpkgs-fmt

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
