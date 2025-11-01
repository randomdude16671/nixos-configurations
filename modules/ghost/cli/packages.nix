{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption;
  cfg = config.ghost.dev.packages;
in
{
  options.ghost.dev.packages = {
    enable = mkEnableOption "Enable all of Ghost's regular dev packages";
    extraPackages = mkOption {
      type = lib.types.listOf lib.types.package;
      description = ''
        any extra packages to be installed through this module
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      let
        inherit (pkgs)
          opencode
          vivid
          duf
          fd
          gh
          sesh
          ;
      in
      [
        opencode
        vivid
        duf
        fd
        gh
        sesh
      ]
      ++ cfg.extraPackages;
  };
}
