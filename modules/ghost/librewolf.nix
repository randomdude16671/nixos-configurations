{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ghost.browser;
in
{
  options.ghost.browser.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Ghost's Browser configurations";
  };
  options.ghost.browser.extensions = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
    description = "Extensions to install";
  };
  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      package = pkgs.librewolf;
      profiles.ghost = {
        name = "ghost";
        isDefault = true;
        search = {
          default = "ddg";
          engines = {
            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "nx" ];
            };
          };
        };
        settings = {
          "browser.startup.homepage" = "file:///home/ghost/Programming/homepage/index.html";
          "signon.rememberSignons" = true;
        };
        extensions.packages = cfg.extensions;
      };
    };
  };
}
