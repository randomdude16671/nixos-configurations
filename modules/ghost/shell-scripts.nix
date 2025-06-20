{
  lib,
  config,
  ...
}: let
  cfg = config.ghost.scripts;
in {
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
      "scripts/install_nvim" = {
        source = ./../scripts/install_neovim.sh;
        executable = true;
      };
      "scripts/maim.sh" = {
        source = ./../scripts/maim.sh;
        executable = true;
      };
      "scripts/swappy.sh" = {
        source = ./../scripts/swappy.sh;
        executable = true;
      };
      "scripts/rebuild.sh" = {
        source = ./../scripts/rebuild.sh;
        executable = true;
      };
    };
  };
}
