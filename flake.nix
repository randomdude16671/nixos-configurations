{
  description = "Ghost's NixOS Flake.";

  inputs = {
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    volt-build.url = "github:volt-build/volt-build/main";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      volt-build,
      nur,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nur.overlay ];
      };
      lib = pkgs.lib;
    in
    {
      nixosConfigurations.hydra = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nur.modules.nixos.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "hm.bak";
            home-manager.users.ghost = {
              home.packages = [
                volt-build.packages."${system}".default
              ];
              imports = [
                ./ghost.nix
              ];
            };
          }
          {
            programs.neovim = {
              enable = true;
              package = inputs.neovim.packages.${system}.default;
              viAlias = true;
              vimAlias = true;
            };
          }
          ./modules/nixos/configuration.nix
        ];
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
