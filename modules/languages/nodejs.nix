{ pkgs, ... }:

{
  home._ = {
    home.sessionVariables = {
      NPM_CONFIG_PREFIX = "$HOME/.node_modules";
    };
    home.packages = with pkgs;
      [
        nodejs
        jq
        #nodePackages."@angular/cli"
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
        "[typescript]" = {
          "editor.defaultFormatter" = "vscode.typescript-language-features";
        };
      };
    };
  };
}
