{ pkgs, ... }:
{
  home._ = {
    home.packages = with pkgs; [
      discord-ptb
    ];
  };
}
