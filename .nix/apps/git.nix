{
  home.shellAliases = {
    gb =
      "git branch --format='%(HEAD) %(refname:short) %(color:green)(%(committerdate:relative)) %(color:blue)[%(authorname)]' --sort=-committerdate";
    gg = "git log --graph --simplify-by-decoration --pretty=format:'%d' --all";
    gl =
      "git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit";
    gs = "git status";
    gu = "git push";
    lg = "lazygit";

    js = "jj st";
    jl = "jj log -l 10";
    jb = "jj branch list";
    je = "jj edit";
    jd = "jj diff";
  };

  programs.git = {
    enable = true;

    userEmail = "Jak-Ch-ll@mailbox.org";
    userName = "J.c";

    extraConfig = { init = { defaultBranch = "main"; }; };

    delta = { enable = true; };

    aliases = {
      save = "!git add -A && git commit -m '🚧 Savepoint'";
      load = "reset HEAD~";
    };
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
