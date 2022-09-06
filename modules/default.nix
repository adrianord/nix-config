{
  nixos = ./nixos;
  darwin = ./darwin;
  standard = [
    ./code.nix
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
