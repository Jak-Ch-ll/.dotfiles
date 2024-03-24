{ pkgs, ... }: {
  imports = [ ./apps/git.nix ./apps/fzf.nix ./apps/neovim.nix ./apps/tmux.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "j";
  home.homeDirectory = "/home/j";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # WSL
    wslu
    wget

    openssh
    jq
    tree
    unzip
  ];

  home.shellAliases = {
    hms = "home-manager switch --flake ~/.dotfiles/.nix/";
  };

  programs.ripgrep.enable = true;

  programs.gh = {
    enable = true;

    settings = {
      # Workaround for https://github.com/nix-community/home-manager/issues/4744
      version = 1;
    };
  };

  home.sessionPath = [
    "$HOME/.dotfiles/.bin"

    # WSL
    # In /etc/wsl.conf we are setting `appendWindowsPath` to false to avoid getting
    # unnecessary binaries added to PATH. We re-add paths as needed here
    "/mnt/c/Windows/"
    "/mnt/c/Windows/system32/"
    "/mnt/d/Programs/Microsoft VS Code/bin/"
    "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/j/etc/profile.d/hm-session-vars.sh
  #

  programs.fish = {
    enable = true;
    shellInit = ''
      bind \cs tmux-session-switcher
      bind \es tmux-session-creator
    '';
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      # start or attach to tmux
      session_name="home"
    
      # https://wiki.archlinux.org/title/Tmux#Start_tmux_on_every_shell_login
      if [ -x "$(command -v tmux)" ] && [ -n "$DISPLAY" ] && [ -z "$TMUX" ]; then
        tmux new-session -A -s $USER >/dev/null 2>&1
      fi
    '';
  };
  programs.zellij = {
    enable = true;
    settings = { default_shell = "fish"; };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # enable flakes
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
