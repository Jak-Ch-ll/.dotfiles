{ self, ... }:
{
  flake.homeModules.shared =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.git
        self.homeModules.neovim
      ];

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
        monaspace
        fd

        wget

        openssh
        jq
        tree
        unzip
        jujutsu

        # docker
        docker
        containerd
        runc

        super-productivity
      ];

      fonts.fontconfig.enable = true;

      home.shellAliases = {
        hms = "home-manager switch --flake ~/.dotfiles/.nix/";
      };

      programs.ripgrep.enable = true;

      programs.starship = {
        enable = true;
        settings = {
          format = ''
            $shell$directory$nix_shell$status
            $character
          '';
          shell = {
            disabled = false;
            fish_indicator = "🐟";
          };
          nix_shell = {
            format = "$symbol";
          };
          status = {
            disabled = false;
          };
        };
      };

      programs.gh = {
        enable = true;

        settings = {
          # Workaround for https://github.com/nix-community/home-manager/issues/4744
          version = 1;
        };
      };

      programs.mise.enable = true;

      programs.fzf.enable = true;

      home.sessionPath = [
        "$HOME/.dotfiles/.bin"
      ];

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.fish.enable = true;
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
      programs.nushell.enable = true;

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
}
