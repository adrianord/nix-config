{ pkgs, config, conf, lib, ... }:


let
  FZF_PREVIEW_BIND = "--bind alt-k:preview-up,alt-j:preview-down";
  FZF_LS_PREVIEW = "ls -la --color {}";
  FZF_BAT_PREVIEW = "bat --decorations always --color always {}";
  FZF_BAT_LS_PREVIEW = "if [ -d {} ]; then ${FZF_LS_PREVIEW} ; else ${FZF_BAT_PREVIEW}; fi";
  FZF_CTRL_T_OPTS = "${FZF_PREVIEW_BIND} --preview '${FZF_BAT_LS_PREVIEW}'";

in
{
  users.users.${conf.user.name} = lib.mkIf (conf.host.os == "linux") {
    shell = pkgs.zsh;
  };
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
  ];

  home._ = {
    home.packages = with pkgs; [
      fd
      bat
      nix-zsh-completions
    ];
    home.sessionVariables = {
      FZF_PREVIEW_BIND = FZF_PREVIEW_BIND;
      FZF_LS_PREVIEW = FZF_LS_PREVIEW;
      FZF_BAT_PREVIEW = FZF_BAT_PREVIEW;
      FZF_BAT_LS_PREVIEW = FZF_BAT_LS_PREVIEW;
      FZF_CTRL_T_OPTS = FZF_CTRL_T_OPTS;
    };
    programs.zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      history = {
        extended = true;
        ignorePatterns = [
          "reboot"
        ];
        size = 999999999;
      };
      shellAliases = {
        switch = "darwin-rebuild switch --flake ~/.config/darwin";
        ls = "ls --color=auto";
        la = "ls -lAh";
        cdcode = "cd ~/Code";
        cddot = "cd ~/.config/darwin";
        g = "git";
      };
      completionInit = ''
        autoload -Uz compinit
        compinit -d "''${XDG_CACHE_HOME:-''${HOME}/.cache}/zsh/zcompdump-''${ZSH_VERSION}"
        zmodload zsh/complist
        zstyle ':completion:*' menu select=0 interactive
        setopt menucomplete
      '';

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "master";
            sha256 = "sha256-GI1+uEpxiMGYiXxfWr1+XtJroFRyX0LhpD7q3zft1E4=";
          };
        }
      ];
      initExtra = ''
        bindkey '^F' fzf-cd-widget
        bindkey '^Y' fzf-file-widget
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
    };
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
      };
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type d --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--reverse"
      ];
    };
  };
}
