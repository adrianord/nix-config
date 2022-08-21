{ pkgs, ... }:

{
  imports = [
    ./dotnet.nix
    ./python.nix
    ./nix.nix
  ];
  home._ = {
    home.packages = with pkgs; [
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
