{ pkgs, ... }:

{
  home._ = {
    home.sessionVariables = {
      EDITOR = "vim";
    };
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
