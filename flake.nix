{
  description = "adrianord nix-config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vscodeInsiders.url = "github:cideM/visual-studio-code-insiders-nix";

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, darwin, nixpkgs, home-manager, ... }:
    let
      # TODO: Come up with better logic for loading config.toml, check several locations.
      conf = builtins.fromTOML (builtins.readFile (toString ./config.toml));
      overlays = import ./overlays { inherit inputs; };

      modulePacks = import ./modules;
      host = {
        "linux" = {
          configurations = "nixosConfigurations";
          system = nixpkgs.lib.nixosSystem;
          modules = [
            modulePacks.nixos
            home-manager.nixosModules.home-manager
          ];
        };
        "darwin" = {
          configurations = "darwinConfigurations";
          system = darwin.lib.darwinSystem;
          modules = [
            modulePacks.darwin
            home-manager.darwinModules.home-manager
          ];
        };
      }.${conf.host.os};
      enabledModulePacks = builtins.concatMap (x: modulePacks.${x}) conf.modulePacks or [ "standard" ];
      extraModules = map (x: ./modules/${x}) conf.modules or [ ];
      extraPackages = map (x: nixpkgs.${x}) conf.packages or [ ];
    in
    {
      "${host.configurations}"."${conf.host.name}" = host.system {
        system = conf.host.arch + "-" + conf.host.os;
        specialArgs = { inherit inputs conf; };
        modules = host.modules ++ [
          ./modules/home.nix
          ./modules/nixpkgs.nix
          {
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
          }
          { home._.home.packages = extraPackages; }
        ] ++ enabledModulePacks ++ extraModules;
      };
    };
}
