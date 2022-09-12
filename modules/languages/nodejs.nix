{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs;
      [
        nodejs
      ];

    programs.vscode = {
      extensions = with pkgs.vscode-extensions;[
        ms-vscode.vscode-typescript-next
        dbaeumer.vscode-eslint
        rvest.vs-code-prettier-eslint
        esbenp.prettier-vscode
      ];
      userSettings = {
        eslint = {
          validate = [ "typescript" ];
          format.enable = true;
        };
        prettier = {
          proseWrap = "always";
        };
      };
    };
  };
}
