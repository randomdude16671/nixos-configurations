{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) package;
  cfg = config.ghost.dev.tealdeer;
in
{
  options.ghost.dev.tealdeer = {
    enable = mkEnableOption "Enable Ghost's tealdeer configuraiton";
    package = mkOption {
      type = package;
      description = ''
        The package to use for the tealdeer configuration
      '';
      default = pkgs.tealdeer;
    };
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      inherit (cfg) package;
      enable = true;
      enableAutoUpdates = true;
      settings = {
        display = {
          compact = true;
          use_pager = false;
        };
        updates = {
          auto_update = true;
        };
      };
    };
  };
}
