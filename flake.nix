{
  description = "adrianord nix-config";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
    let
      # TODO: Come up with better logic for loading config.toml, check several locations.
      conf = builtins.fromTOML (builtins.readFile (toString ./config.toml));

      modulePacks = import ./modules;
      hostTypes = {
        "nixos" = {
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
      };
      host = hostTypes.${conf.host.os};
      enabledModulePacks = builtins.concatMap (x: modulePacks.${x}) conf.host.modulePacks or [ "standard" ];
      extraModules = builtins.concatMap (x: ./modules/${x}) conf.host.modules or [ ];
      extraPackages = builtins.concatMap (x: nixpkgs.${x}) conf.host.packages or [ ];
    in
    {
      "${host.configurations}"."${conf.host.name}" = host.system {
        system = conf.host.arch + "-linux";
        specialArgs = { inherit inputs self conf; };
        modules = host.modules ++ [
          {
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
          }
          { nixpkgs.config.allowUnfree = true; }
          { home._.home.packages = extraPackages; }
          ./modules/home.nix
        ] ++ enabledModulePacks ++ extraModules;
      };
    };
}
