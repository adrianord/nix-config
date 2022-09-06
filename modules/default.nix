{
  nixos = ./nixos;
  darwin = ./darwin;
  standard = [
    ./vscode
    ./kubernetes.nix
    ./languages
    ./neovim.nix
    ./zsh.nix
    ./git.nix
    ./firefox.nix
    ./direnv.nix
  ];
  personal = [
    ./personal
  ];
}
