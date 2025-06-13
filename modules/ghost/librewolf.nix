{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ghost.browser;
in {
  options.ghost.browser.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Ghost's Browser configurations";
  };
  options.ghost.browser.extensions = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [];
    description = "Extensions to install";
  };
  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      package = pkgs.librewolf;
      profiles.ghost = {
        name = "ghost";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "file:///home/ghost/Project/homepage/index.html";
          "signon.rememberSignons" = true;
        };
        extensions.packages = cfg.extensions;
      };
    };
  };
}
