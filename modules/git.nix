{ pkgs, conf, lib, ... }:

let
  includes = lib.mapAttrsToList
    (name: value: {
      condition = "gitdir:~/Code/work/${name}/";
      contents = {
        user = {
          email = value.email;
        };
        init = {
          defaultBranch = value.git.initBranch or "main";
        };
      };
    })
    conf.user.work or { };
in
{
  home._.programs.git = {
    enable = true;
    userName = conf.user.fullname;
    userEmail = conf.user.email;
    inherit includes;
    aliases = {
      a = "add";
      b = "branch";
      c = "commit";
      d = "diff";
      l = "log";
      m = "merge";
      r = "rebase";
      s = "status";
      co = "checkout";
      dt = "difftool";
      ps = "push";
      pl = "pull";
      lol = "log --oneline";
      amend = "commit --no-edit --amend";
      cl = "clone";
    };
    extraConfig = {
      pull = {
        rebase = true;
      };
      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        whitespace-error-style = "22 reverse";
        syntax-theme = "Monokai Extended";
        navigation = true;
        plus-style = "syntax #012800";
        minus-style = "syntax #340001";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
        };
      };
    };
  };
}
