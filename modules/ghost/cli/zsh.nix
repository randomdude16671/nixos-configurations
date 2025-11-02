{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  cfg = config.ghost.dev.zsh;
in
{
  options.ghost.dev.zsh = {
    enable = mkEnableOption "Enable Ghost's Zsh configuration";

    plugins = mkOption {
      type = types.listOf (
        types.submodule (
          { config, ... }:
          {
            options = {
              name = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Plugin name for Zsh plugin loader";
              };
              src = mkOption {
                type = types.nullOr types.package;
                default = null;
                description = "Source package or path for the plugin.";
              };
              file = mkOption {
                type = types.str;
                description = "Path to the plugin entrypoint file.";
              };
            };
          }
        )
      );
      default = [ ];
      description = "List of Zsh plugins to load.";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autocd = true;
      initContent = builtins.readFile ../non-nix/zsh/rc.zsh;

      syntaxHighlighting.enable = true;
      inherit (cfg) plugins;

      shellAliases = {
        "clear" = "";
        "cd" = "z";
        "ci" = "zi";
        "cl" = "${pkgs.toybox}/bin/clear -x";
      };
    };

    home.file = {
      ".zsh/zprompt.zsh".source = ../non-nix/zsh/zprompt.zsh;
      ".zsh/binds.zsh".source = ../non-nix/zsh/binds.zsh;
    };
  };
}
