{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./modules/home
    ./modules/ghost
  ];
  # custom modules
  ghost = {
    dev = {
      enable = true;
    };
    scripts.enable = true;
    vesktop = {
      enable = true;
      useSystem = false;
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
  };
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
