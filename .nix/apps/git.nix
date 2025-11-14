{ lib, ... }:
let
  aliases = {
    gb = "git branch --format='%(HEAD) %(refname:short) %(color:green)(%(committerdate:relative)) %(color:blue)[%(authorname)]' --sort=-committerdate";
    gg = "git log --graph --simplify-by-decoration --pretty=format:'%d' --all";
    gl = "git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit";
    gs = "git status";
    gu = "git push";
    lg = "lazygit";

    js = "jj st";
    jl = "jj log -n 10";
    jb = "jj bookmark list";
    je = "jj edit";
    jd = "jj diff";

  };
in
{
  home.shellAliases = lib.mkMerge [
    aliases
    { gbs = "git branch | fzf | xargs git switch"; }
  ];
  programs.nushell = {
    shellAliases = aliases;
    extraConfig = "def gbs [] { git branch | fzf | xargs git switch }";
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        email = "Jak-Ch-ll@mailbox.org";
        name = "Jak-Ch-ll";
      };

      init = {
        defaultBranch = "main";
      };

      alias = {
        save = "!git add -A && git commit -m '🚧 Savepoint'";
        load = "reset HEAD~";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}
