This is my (currently experimental) user setup with Nix and Home Manager

## Setup

1. [Install Nix](https://nixos.org/download#download-nix)

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

2. Run Home Manager with Flakes ([See manual](https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes))

```sh
nix --extra-experimental-features "nix-command flakes" run home-manager/master -- init --switch
```

## Apply changes

Run the following in the `.dotfiles/` directory

```sh
home-manager switch --flake .nix/
```

