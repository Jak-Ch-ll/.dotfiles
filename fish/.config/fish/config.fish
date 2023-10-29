if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
bind \cs tmux-session-switcher
bind \es tmux-session-creator

# PATH

set -gx PATH "$HOME/.dotfiles/.bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH

## Rust
set -gx PATH "$HOME/.cargo/bin" $PATH

## Go
set -gx PATH "/usr/local/go/bin" $PATH
set -gx PATH "$HOME/go/bin" $PATH

## neovim-bob
set -gx PATH "$HOME/.local/share/neovim/bin" $PATH

# pnpm
set -gx PNPM_HOME "/home/jchill/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
