if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
bind \cs tmux-session-switcher
bind \es tmux-session-creator


set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "/usr/local/go/bin" $PATH
set -gx PATH "$HOME/go/bin" $PATH
