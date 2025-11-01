{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ghost.fuzzel;
in
{
  options.ghost.fuzzel.enable = mkEnableOption "Enable fuzzel";

  config = mkIf cfg.enable {
    programs.fuzzel.enable = true;
  };
}
