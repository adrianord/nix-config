{ inputs }:

{
  common = [
    (import ./nur.nix inputs)
    (import ./vscodeInsiders.nix inputs)
  ];
  darwin = [
    inputs.firefox-darwin.overlay
  ];
  linux = [
  ]; 
}