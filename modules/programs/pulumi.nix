{ pkgs, ... }:

{
  home._.home.packages = with pkgs; [
    pulumi-bin
  ];
}
