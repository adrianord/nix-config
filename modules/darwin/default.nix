{ self, config, conf, pkgs, ... }:

{
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  programs.nix-index.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;

  homebrew = {
    enable = true;
    taps = [
      "homebrew/cask-fonts"
    ];
    casks = [
      "raycast"
      "iterm2"
      "karabiner-elements"
      "alt-tab"
      "multitouch"
      "rectangle"
      "spotify"
      "obsidian"
      "nordvpn"
      "notion"
      "font-inconsolata-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "microsoft-remote-desktop"
      "unnaturalscrollwheels"
    ];
  };

  home._ = { config, pkgs, ... }: {
    home.file."Applications/Home Manager Apps".source =
      let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
      "${apps}/Applications";
  };

  security.pki.certificates = conf.trusted;

  users.users.aordonez = {
    name = "aordonez";
    home = "/Users/aordonez";
  };
}
