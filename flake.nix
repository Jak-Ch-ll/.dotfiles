# Links:
# - https://www.youtube.com/watch?v=aNgujRXDTdE
# - https://www.vimjoyer.com/vid79-parts-wrapped
#
# - https://flake.parts/
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # inputs.home-manager.flakeModules.home-manager
        (inputs.import-tree ./modules)
      ];
    };
}
