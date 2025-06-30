{
  pkgs,
  inputs,
  lib,
  ...
}: {
  home-manager.backupFileExtension = "hmBak";
  home-manager.users.ghost = {
    home.packages = with pkgs; [
      # all gui apps
      inputs.volt-build.packages."${system}".default # my build system thing
      authenticator
      i3status
      rofi
      vesktop
      nsxiv
      wl-clipboard
    ];
    imports = [
      ./modules/home-manager
      ./modules/ghost
    ];
    gtk.enable = true;

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
        youtube-recommended-videos
      ];
    };

    home.stateVersion = "24.11";
    programs.home-manager.enable = true; # let it cook bro.
  };
}
