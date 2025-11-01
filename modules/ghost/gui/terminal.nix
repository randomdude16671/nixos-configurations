{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption mkIf;
  cfg = config.ghost.dev.terminal;
in
{
  options.ghost.dev.terminal = {
    enable = mkEnableOption "Enable Ghost's Foot configurations";
  };
  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "IosevkaTerm Nerd Font:size=10";
          term = "foot";
          dpi-aware = "yes";
        };
        colors = {
          alpha = 0.9;
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
