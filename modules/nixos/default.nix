{ self, conf, ... }:

let
  archModule = if conf.host.arch == "x86_64" then ./x86_64.nix else ./arm64.nix;
in
{
  imports = [
    archModule
    ./system.nix
    ./sway.nix
    ./ssh.nix
  ];
}
