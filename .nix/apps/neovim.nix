{
  config,
  pkgs,
  tree-sitter-cli-custom,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Copilot & Mason
      nodejs_24
      bun

      # telescope-fzf
      gnumake
      clang_multi

      # Language Stuff

      ## Nix
      nixd
      nixfmt

      ## Lua
      stylua
      lua-language-server

      ## Web Dev
      emmet-language-server
      prettierd
      eslint_d
      dprint
      svelte-language-server
      typescript
      vue-language-server
      vscode-langservers-extracted # provides css, eslint, html, json, markdown
      vtsls
      oxfmt
      oxlint

      ## Devops
      docker-compose-language-service
      dockerfile-language-server
      gitlab-ci-ls
      yaml-language-server
      taplo

      ## Rust
      rust-analyzer
      rustfmt
      vscode-extensions.vadimcn.vscode-lldb.adapter

      ## Go
      gopls

      # Misc
      tree-sitter-cli-custom # for v0.26
      xclip
    ];
  };

  home.file = {
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim/.config/nvim";
  };

  # $TERM: https://github.com/wezterm/wezterm/issues/415#issuecomment-756155971
  # other stuff: https://github.com/yyx990803/launch-editor?tab=readme-ov-file#custom-editor-support
  home = {
    shellAliases = {
      # vim = "TERM=wezterm nvim --listen ./nvim.pipe";
      vim = "TERM=wezterm nvim";
    };
    sessionVariables = {
      LAUNCH_EDITOR = "open-in-neovim.sh";
    };
  };
}
