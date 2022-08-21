{
  description = "adrianord nix-config";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vscodeInsiders.url = "github:cideM/visual-studio-code-insiders-nix";

  };

  outputs = { self, darwin, nixpkgs, home-manager, vscodeInsiders, ... }@inputs:
    let
      # TODO: Come up with better logic for loading config.toml, check several locations.
      conf = builtins.fromTOML (builtins.readFile (toString ./config.toml));

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
      enabledModulePacks = builtins.concatMap (x: modulePacks.${x}) conf.host.modulePacks or [ "standard" ];
      extraModules = map (x: ./modules/${x}) conf.host.modules or [ ];
      extraPackages = map (x: nixpkgs.${x}) conf.host.packages or [ ];
    in
    {
      "${host.configurations}"."${conf.host.name}" = host.system {
        system = conf.host.arch + "-" + conf.host.os;
        specialArgs = { inherit inputs self conf; };
        modules = host.modules ++ [
          ./modules/home.nix
          {
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
          }
          { nixpkgs.config.allowUnfree = true; }
          {
            nixpkgs.overlays = [
              (self: super: {
                vscodeInsiders = vscodeInsiders.packages.${super.system}.vscodeInsiders;
              })
            ];
          }
          { home._.home.packages = extraPackages; }
        ] ++ enabledModulePacks ++ extraModules;
      };
    };
}
