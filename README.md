This is my (currently experimental) user setup with Nix and Home Manager

## Prerequisites

Have `curl` installed and `systemd` enabled

### Debian + WSL

#### 1. Install the necessary packages:

```sh
sudo apt update && sudo apt install curl
```

#### 2. Activate systemd support ([Docs](https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/))

```sh
echo "[boot]\nsystemd=true" > sudo /etc/wsl.conf
```

#### 3. (Optional) Deactivate Windows PATH

```sh
echo "\n[interop]\nappendWindowsPath=False" >> sudo /etc/wsl.conf
```

This avoids a path polleted with binaries installed on Windows. Any needed bin
dir is added back in `home.nix`

#### 4. Restart WSL

```sh
wsl.exe --shutdown
```

## Setup

1. Install Nix via the [Determinate Installer](https://github.com/DeterminateSystems/nix-installer) (Alternativly use the [offical installer](https://nixos.org/download#download-nix) but then you have to enable flakes and nix-commands afterwards)

Note: We currently don't want to go above v2.18.1 because of [#4692](https://github.com/nix-community/home-manager/issues/4692)

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/tag/v0.15.1 | sh -s -- install
```

Restart shell

2. Delete (and backup if needed) the following files

```sh
rm ~/.profile ~/.bashrc
```

3. Run Home Manager with Flakes ([See manual](https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes))

```sh
nix run home-manager/master -- switch --flake "github:Jak-Ch-ll/.dotfiles/nix?dir=.nix"
```

4. Clone this repo

```sh
git clone --branch nix https://github.com/Jak-Ch-ll/.dotfiles.git
```

5. Restart shell

## Postinstall

- tmux will automatically start, press `C-b` to install the plugins

## Apply changes

To apply configuration changes just run `hms` from anywhere
