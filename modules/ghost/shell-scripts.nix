{
  lib,
  config,
  ...
}:
let
  cfg = config.ghost.scripts;
in
{
  options.ghost.scripts.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Ghost's Shell scripts.";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      "scripts/sesh_start.sh" = {
        source = ./../scripts/sesh_start.sh;
        executable = true;
      };
      "scripts/speedfiles.sh" = {
        source = ./../scripts/speedfiles.sh;
        executable = true;
      };
      "scripts/i3-tile.sh" = {
        source = ./../scripts/i3-tile.sh;
        executable = true;
      };
    };
  };
}
