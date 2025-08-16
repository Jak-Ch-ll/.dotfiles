{
  description = "Home Manager configuration of j";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    tree-sitter-flake = {
      url = "github:tree-sitter/tree-sitter/release-0.26";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      tree-sitter-flake,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."j" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          tree-sitter-cli-custom = tree-sitter-flake.packages.x86_64-linux.cli;
        };

        modules = [
          ./home.nix
        ];
      };
    };
}
