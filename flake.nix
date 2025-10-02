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
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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
      zen-browser,
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
            programs.neovim = {
              package = pkgs.neovim;
              enable = true;
              viAlias = true;
              vimAlias = true;
              defaultEditor = true;
            };
          }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "old.hm.bak";
              users.ghost = {
                home.packages = [
                  volt-build.packages."${system}".default
                ];
                imports = [
                  ./ghost.nix
                  zen-browser.homeModules.beta # get the programs.zen-browser module into HM
                ];
              };
            };
          }
          {
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
          }
          ./modules/nixos/configuration.nix
        ];
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
