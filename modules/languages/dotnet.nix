{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs; [
      dotnet-sdk
      jetbrains.rider
    ];
    home.sessionPath = [
      "$HOME/.dotnet/tools"
    ];
    programs.zsh.initExtra = ''
      _dotnet_zsh_complete()
      {
        #compdef dotnet
        local completions=("$(dotnet complete "$words")")
        [[ -n "$completions" ]] && compadd -- "''${(ps:\n:)completions}"
      }

      compdef _dotnet_zsh_complete dotnet
    '';
  };
}
