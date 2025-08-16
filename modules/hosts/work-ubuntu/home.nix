{ self, inputs, ... }:
{

  flake.homeConfigurations.work-ubuntu =
    let
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    in

    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        self.homeModules.shared
        self.homeModules.tmux
        {
          # enable flakes
          nix = {
            package = pkgs.nix;
            settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          };
        }
      ];
    };
}
