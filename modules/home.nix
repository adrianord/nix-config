{ config, conf, pkgs, lib, options, inputs, ... }:

# https://rycee.gitlab.io/home-manager/options.html
with lib;
{
  options = with types; {
    home = {
      _ = mkOption {
        type = attrs;
        default = { };
        description = "For passing arbitrary configuration to user's home-manager config";
      };
    };
  };
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home._ = {
      home.stateVersion = "22.11";
    };
    home-manager.users.${conf.user.name} = mkAliasDefinitions options.home._;
    
  };
}
