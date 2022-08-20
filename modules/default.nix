{
  nixos = ./nixos;
  darwin = ./darwin;
  standard = [
    ./code.nix
    ./kubernetes.nix
    ./languages
    ./neovim.nix
    ./zsh.nix
  ];
}
