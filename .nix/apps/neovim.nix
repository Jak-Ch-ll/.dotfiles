{
  config,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Copilot & Mason
      nodejs_22
      bun

      # telescope-fzf
      gnumake
      clang_multi

      # Language Stuff
      ## Nix
      nixfmt-rfc-style
      ## JS/TS
      typescript
      prettierd
      ## Lua
      stylua

      # Misc
      tree-sitter
    ];
  };

  home.file = {
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim/.config/nvim";
  };

  # https://github.com/yyx990803/launch-editor?tab=readme-ov-file#custom-editor-support
  home = {
    shellAliases = {
      vim = "nvim --listen ./nvim.pipe";
    };
    sessionVariables = {
      LAUNCH_EDITOR = "open-in-neovim.sh";
    };
  };
}
