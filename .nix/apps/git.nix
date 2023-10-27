{
  programs.git = {
    enable = true;

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };

    delta = {
      enable = true;
    };
  };
}
