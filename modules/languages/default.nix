{ pkgs, ... }:

{
  imports = [
    ./dhall.nix
    ./dotnet.nix
    ./go.nix
    ./nix.nix
    ./nodejs.nix
    ./python.nix
    ./rust.nix
    ./toml.nix
    ./vale.nix
    ./yaml.nix
  ];
}
