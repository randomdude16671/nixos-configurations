{
  pkgs,
  inputs,
  lib,
  ...
}: {
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "hmBak";
  home-manager.users.ghost = {
    home.packages = with pkgs; [
      # all gui apps
      inputs.volt-build.packages."${system}".default # my build system thing
      authenticator
      i3status
      rofi-wayland
      nixd
      vesktop
      nsxiv
      azahar
      wl-clipboard
    ];
    imports = [
      ./modules/home-manager
      ./modules/ghost
    ];
    gtk.enable = true;

    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };

    # yes these are my own modules
    ghost = {
      devTools.enable = true;
      scripts.enable = true;
      browser.enable = true;

      # this list may change in the future
      # goated extensions I currently use
      browser.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        ghostery
        vimium
        new-tab-override
        youtube-recommended-videos # unhook
      ];
    };

    home.stateVersion = "24.11";
    programs.home-manager.enable = true; # let it cook bro.
  };
}
