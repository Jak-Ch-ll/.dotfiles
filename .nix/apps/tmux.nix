{ pkgs, ... }:
let
  tpm = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tpm";
    version = "unstable-2023-11-13";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
      sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";
    mouse = true;
    terminal = "tmux-256color";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 0;

    extraConfig = ''
      set -g status-position top

      # Vim-like pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set -ga terminal-overrides ',xterm-256color:Tc'

      set -g @catppuccin_status_modules_right "session"

      # required for Neovim's 'autoread' feature
      set-option -g focus-events on
    '';

    plugins = [
      {
        plugin = tpm;
        extraConfig = ''
          set -g @plugin 'jimeh/tmux-themepack'
          set -g @themepack 'powerline/default/purple'
          run-shell '${tpm}/share/tmux-plugins/tpm/tpm'

          # show git branch in status bar
          set -g status-right '[#(jj-git-rev #{pane_current_path})]'
        '';
      }
    ];
  };
}
