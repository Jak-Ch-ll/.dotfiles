{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Copilot & Mason
      nodejs_20

      # telescope-fzf
      gnumake
      clang_multi

      # Language Stuff
      ## Nix
      nixfmt
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
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/nvim/.config/nvim";
  };
}
