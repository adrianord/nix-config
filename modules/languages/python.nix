{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs; [
      python310
      python310Packages.virtualenv
      python310Packages.virtualenvwrapper
    ];

    programs.zsh.initExtra = ''
      source virtualenvwrapper.sh
    '';
  };
}
