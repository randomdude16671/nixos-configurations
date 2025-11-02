{
  description = "Ghost's NixOS Flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    fontman = {
      url = "github:randomdude16671/fontman";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    agenix.url = "github:ryantm/agenix";
    nur = {
      url = "github:nix-community/NUR";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nur,
      neovim,
      agenix,
      zen-browser,
      fontman,
      catppuccin,
      spicetify-nix,
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
    in
    {
      devShells.${system}.nvim =
        let
          inherit (pkgs) lua-language-server stylua clang;
        in
        pkgs.mkShell {
          name = "nixos";
          packages = [
            lua-language-server
            stylua
            clang
          ];
        };

      nixosConfigurations.grimm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          nur.modules.nixos.default
          agenix.nixosModules.default
          home-manager.nixosModules.default
          fontman.nixosModules.fontman
          catppuccin.nixosModules.catppuccin
          {
            programs.neovim = {
              enable = true;
              package = pkgs.neovim;
              defaultEditor = true;
              viAlias = true;
            };
          }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              backupFileExtension = "old.hm.bak";
              users.ghost = {
                home.packages = [
                  agenix.packages."${system}".default
                ];
                imports = [
                  ./ghost.nix
                  agenix.homeManagerModules.default
                  spicetify-nix.homeManagerModules.spicetify
                  zen-browser.homeModules.beta # get the programs.zen-browser module into HM
                  catppuccin.homeModules.catppuccin
                ];
              };
            };
          }
          {
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
          }
          ./modules/nixos/base.nix
        ];
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
