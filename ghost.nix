{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./modules/home
    ./modules/ghost
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.comfy;
    };

  ghost = {
    dev = {
      enhancements.enable = true;
      tealdeer = {
        enable = true;
        package = pkgs.tealdeer;
      };
      nh = {
        enable = true;
        package = pkgs.nh;
      };
      packages = {
        enable = true;
        extraPackages =
          let
            inherit (pkgs)
              imv
              wl-clipboard
              proton-pass
              imagemagick
              proton-authenticator
              statix
              ;
          in
          [
            imv
            wl-clipboard
            proton-pass
            imagemagick
            proton-authenticator
            statix
          ];
      };
      scripts.enable = true;
      tmux.enable = true;
      terminal.enable = true;
      zsh = {
        enable = true;
        plugins = [
        ];
      };
    };
    browser = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        ghostery
        vimium
        youtube-recommended-videos # unhook
        proton-pass
      ];
    };
    fuzzel.enable = true;
    vesktop = {
      enable = true;
      useSystem = false;
    };
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
