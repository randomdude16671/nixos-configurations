{ pkgs, ... }:
let
  waybarStyle = builtins.readFile ./waybar/style.css;
  waybarSettings = ./waybar/config.json;
in
{
  home.packages =
    let
      inherit (pkgs) bluetui wiremix;
    in
    [
      bluetui
      wiremix
    ];
  xdg.configFile."waybar/config.jsonc".source = waybarSettings;

  programs.waybar = {
    enable = true;
    style = waybarStyle;
  };
}
