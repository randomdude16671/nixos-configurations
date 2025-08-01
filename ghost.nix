{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./modules/home
    ./modules/ghost
  ];
  # custom modules
  ghost = {
    dev.enable = true;
    scripts.enable = true;
    browser = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        ghostery
        vimium
        new-tab-override
        youtube-recommended-videos # unhook
      ];
    };
  };
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
