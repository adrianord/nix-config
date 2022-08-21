{ pkgs, lib, ... }:

let
  dhall-lsp-server = pkgs.haskellPackages.callCabal2nixWithOptions "dhall-lsp-server" (builtins.fetchTarball {
    url = "https://hackage.haskell.org/package/dhall-lsp-server-1.1.2/dhall-lsp-server-1.1.2.tar.gz";
    sha256 = "14h3d4bh7ws073bl6vh7mpxppizh6bvdpwamyzpx9nl6zr631j1y";
  }) "--no-check" { };
in
{
  home._ = {
    home.packages = with pkgs;[
      dhall
      dhall-nix
    ] ++ [ dhall-lsp-server ];
  };
}
