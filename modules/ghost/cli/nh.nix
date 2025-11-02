{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) nullOr package;
  cfg = config.ghost.dev.nh;
in
{
  options.ghost.dev.nh = {
    enable = mkEnableOption "Enable Ghost's NH Config";
    package = mkOption {
      type = nullOr package;
      default = pkgs.nh;
      description = ''
        The package to use for NH.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      let
        inherit (pkgs) nix-output-monitor nvd;
      in
      [
        nix-output-monitor
        nvd
      ];
    programs.nh = {
      enable = true;
      flake = "/home/ghost/nixos";
      package = if cfg.package != null then cfg.package else pkgs.nh;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };
}
