{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ghost.dev.tmux;
in
{
  options.ghost.dev.tmux.enable = mkEnableOption "Enable Ghost's tmux configurations";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.tmux
    ];
    xdg.configFile = {
      "tmux/tmux.conf".text = builtins.concatStringsSep "\n" [
        "set-option -g default-shell ${pkgs.zsh}/bin/zsh"
        "set-option -g default-command '${pkgs.zsh}/bin/zsh -l'"
        (builtins.readFile ../non-nix/tmux/tmux.conf)
      ];
      "tmux/navigator.tmux" = {
        source = ../non-nix/tmux/vim-tmux-navigator.tmux;
        executable = true;
      };
    };
  };
}
