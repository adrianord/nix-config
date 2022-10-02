{ pkgs, ... }:

{
  home._.home.packages = with pkgs; [
    # azure-cli
  ];
}
