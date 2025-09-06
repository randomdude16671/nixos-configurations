{
  description = "Ghost's NixOS Flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    volt-build = {
      url = "github:volt-build/volt-build/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      volt-build,
      nur,
      neovim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nur.overlays.default
          neovim.overlays.default
        ];
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
            home-manager.backupFileExtension = "hm.backup";
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
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
          }
          {
            programs.neovim = {
              enable = true;
              package = pkgs.neovim; # just in case, you feel me?
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
