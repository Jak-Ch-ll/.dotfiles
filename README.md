This is my (currently experimental) user setup with Nix and Home Manager

## Prerequisites

Install `git`, `curl` and `xz`

### Debian + WSL

#### 1. Install the necessary packages:

```sh
sudo apt update
sudo apt install git curl xz-utils
```

#### 2. Activate systemd support ([Docs](https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/))

```sh
sudo vi /etc/wsl.conf
```

Add the following:

```
[boot]
systemd=true
```

Restart WSL

```sh
wsl.exe --shutdown
```

## Setup

1. [Install Nix](https://nixos.org/download#download-nix)

Note: We are currently installing v2.18.1 because of [#4692](https://github.com/nix-community/home-manager/issues/4692)

```sh
sh <(curl -L https://releases.nixos.org/nix/nix-2.18.1/install) --daemon
```

Restart shell

2. Clone this repo

```sh
git clone https://github.com/Jak-Ch-ll/.dotfiles.git
```

3. Cd into the directory and switch to branch `nix`

```sh
cd .dotfiles
git switch nix
```

4. Delete (and backup if needed) the following files

```sh
rm ~/.profile ~/.bashrc
```

5. Run Home Manager with Flakes ([See manual](https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes))

```sh
nix --extra-experimental-features "nix-command flakes" run home-manager/master -- init --switch
nix --extra-experimental-features "nix-command flakes" run home-manager/master -- --extra-experimental-features "nix-command flakes" switch flake .nix/
```

Restart shell

## Postinstall

- tmux will automatically start, press `C-b` to install the plugins

## Apply changes

Run the following in the `.dotfiles/` directory

```sh
home-manager switch --flake .nix/
```

