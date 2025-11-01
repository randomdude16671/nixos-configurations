{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.ghost.dev.enhancements;
in
{
  options.ghost.dev.enhancements.enable = mkEnableOption "Enable some devleopment enhancement tools";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      DIRENV_WARN_TIMEOUT = 0; # give more time for shell development in direnv
      EDITOR = "nvim";
    };

    programs = {
      bat.enable = true; # generate catppuccin theme through HM
      btop.enable = true; # generate catppuccin theme through HM
      direnv = {
        enable = true;
        enableZshIntegration = true;
        silent = true;
        nix-direnv.enable = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
        tmux.enableShellIntegration = true;
      };
    };
  };
}
