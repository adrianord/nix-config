{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs; [
      vale
    ];
  };
}
