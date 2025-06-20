# devTools module for my developer tools;
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.ghost.devTools;
  zshInitContent = builtins.readFile ./initContent.zsh;
in {
  options.ghost.devTools.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Ghost's Dev Tools.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Bat extensions
      bat-extras.batman
      bat-extras.batdiff
      bat-extras.batpipe

      # Normal packages
      bat
      neovim
      sesh
      zoxide
      btop
      fd
      unzip
      arduino-ide
      eza
      gum
      direnv
      nix-direnv
      fzf
      alejandra
      tmux
      ripgrep
      gh
      alacritty
    ];
    # smart cd command
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    home.file.".zsh/ctp_mocha.zsh".source = ./ctp_mocha.zsh;

    home.sessionVariables = {
      DIRENV_WARN_TIMEOUT = 0;
    };
    xdg.configFile = {
      # terminal
      "alacritty/alacritty.toml" = {
        source = ./alacritty-config.toml;
      };
      "tmux/tmux.conf" = {
        source = ./tmux.conf;
      };

      # cat alternative
      "bat/themes/Catppuccin_Mocha.tmTheme" = {
        source = ./catppuccin_bat.tmTheme;
      };
      "rofi/config.rasi" = {
        source = ./rofi.rasi;
      };
      "rofi/themes/catppuccin-mocha.rasi" = {
        source = ./ctp-rofi.rasi;
      };
      "bat/config" = {
        text = ''
          --theme='Catppuccin_Mocha'
        '';
      };
    };
    home.file.".zsh/git-aliases.zsh".source = ./git-zsh.zsh;

    # for auto dev-shell (i use)
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      silent = false;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };

    # fuzzy finder
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux = {
        enableShellIntegration = true;
      };
    };

    # shell
    programs.zsh = {
      enable = true;
      initContent = zshInitContent;
      syntaxHighlighting.enable = true;
      # raw plugin management through Nix. No need for zinit, zplug or antidote (or anything similar)
      plugins = [
        # taken from the README
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      autocd = true;
      shellAliases = {
        "gs" = "git status";
        "mb" = "mini-build";
        "ls" = "eza";
        "cat" = "bat";
        "cd" = "z";
        "clear" = "";
        # to prevent the `clear` alias from interfereing
        "cl" = "${pkgs.ncurses}/bin/clear -x";
        "vi" = "nvim";
        "vim" = "nvim";
        "rebuild" = "~/scripts/rebuild.sh";
        "grep" = "rg";
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      ZVM_CURSOR_STYLE_ENABLED = "false";
    };
  };
}
