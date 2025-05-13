{
  description = "Ghost's NixOS Flake.";

  inputs = {
    ghostty.url = "github:ghostty-org/ghostty";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    ghostty,
    home-manager,
    zen-browser,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        ./ghost.nix
      ];
    };
  };
}
