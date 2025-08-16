{
  flake.homeModules.wezterm =
    {
      config,
      ...
    }:
    {
      programs.wezterm.enable = true;

      home.file = {
        ".config/wezterm".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/wezterm";
      };

      home.sessionVariables = {
        TERM = "wezterm";
      };
    };
}
