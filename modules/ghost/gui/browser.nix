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
  options.ghost.browser = {
    enable = lib.mkEnableOption "Enable Ghost's browser configurations";
    extensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extensions to install";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      profiles.ghost = {
        name = "ghost";
        isDefault = true;
        search = {
          default = "ddg";
          engines = {
            perplexity = {
              name = "Perplexity AI";
              urls = [
                {
                  template = "https://perplexity.ai";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "prx" ];
            };
            nixos-options = {
              name = "NixOS Options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
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
              definedAliases = [ "nopt" ];
            };
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
          "signon.rememberSignons" = true;
          "privacy.resistFingerprinting" = true;
        };
        extensions.packages = cfg.extensions;
      };
    };
  };
}
