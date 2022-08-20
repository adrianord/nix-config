{ pkgs, ... }:

{
  home._ = {
    home.packages = with pkgs; [
      kubectl
      kubectx
      kubernetes-helm
      k9s
    ];
    programs.zsh.initExtra = ''
      source <(kubectl completion zsh)
      source <(helm completion zsh)
    '';
  };
}
