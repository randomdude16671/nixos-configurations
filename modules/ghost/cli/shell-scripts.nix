{
  lib,
  config,
  ...
}:
let
  cfg = config.ghost.dev.scripts;
in
{
  options.ghost.dev.scripts.enable = lib.mkEnableOption "Enable Ghost's Shell scripts";

  config = lib.mkIf cfg.enable {
    home.file = {
      "scripts/sesh_start.sh" = {
        source = ../../scripts/sesh_start.sh;
        executable = true;
      };
      "scripts/install_nvim" = {
        source = ../../scripts/install_neovim.sh;
        executable = true;
      };
      "scripts/maim.sh" = {
        source = ../../scripts/maim.sh;
        executable = true;
      };
      "scripts/swappy.sh" = {
        source = ../../scripts/swappy.sh;
        executable = true;
      };
      "scripts/lock.sh" = {
        source = ../../scripts/lock.sh;
        executable = true;
      };
      "scripts/swayidle.sh" = {
        source = ../../scripts/swayidle.sh;
        executable = true;
      };
      "scripts/sesh_session_switch.sh" = {
        source = ../../scripts/sesh_session_switch.sh;
        executable = true;
      };
      "scripts/wallpapers.sh" = {
        source = ../../scripts/wallpapers.sh;
        executable = true;
      };
    };
  };
}
