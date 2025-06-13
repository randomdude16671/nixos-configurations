{
  description = "Ghost's NixOS Flake.";

  inputs = {
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mini-build.url = "github:randomdude16671/mini-build";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [nur.overlay];
    };
    lib = pkgs.lib;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        nur.modules.nixos.default
        ./configuration.nix
        ./ghost.nix
      ];
    };
    formatter.${system} = pkgs.alejandra;
  };
}
