{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ghost.vesktop;
in
{
  options.ghost.vesktop = {
    enable = lib.mkEnableOption "Enable Ghost's vesktop configurations";
    useSystem = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use vencord from Nixpkgs.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      vencord = {
        inherit (cfg) useSystem;
        settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          disableMinSize = true;
          plugins = {
            FakeNitro.enabled = true;
          };
        };
      };
    };
  };
}
