{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.ghost.dev;
  zshInitContent = builtins.readFile ./zsh/initContent.zsh;
  tmuxConf = builtins.concatStringsSep "\n" [
    "set-option -g default-shell ${pkgs.zsh}/bin/zsh"
    (builtins.readFile ./tmux/tmux.conf)
  ];
in {
  options.ghost.dev.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable Ghost's Dev Tools.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      hyperfine
      zk
      sesh
      zoxide
      btop
      fd
      arduino-ide
      eza
      gum
      tmux
      ripgrep
      gh
      duf
    ];

    home.file.".zsh/ctp_mocha.zsh".source = ./zsh/ctp_mocha.zsh;
    home.file.".zsh/git-aliases.zsh".source = ./zsh/git-zsh.zsh;

    home.sessionVariables = {
      DIRENV_WARN_TIMEOUT = 0;
      EDITOR = "nvim";
      ZVM_CURSOR_STYLE_ENABLED = "false";
    };

    xdg.configFile = {
      # terminal
      "tmux/tmux.conf".text = tmuxConf;

      # cat alternative
      "bat/themes/Catppuccin_Mocha.tmTheme".source = ./bat/catppuccin.tmTheme;
      "bat/config".text = ''
        --theme='Catppuccin_Mocha'
        --pager='less -FR'
      '';

      # app launcher
      "rofi/config.rasi".source = ./rofi/rofi.rasi;
      "rofi/themes/catppuccin-mocha.rasi".source = ./rofi/ctp-rofi.rasi;
    };

    # for auto dev-shell
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      silent = false;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };

    # smart cd command
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # fuzzy finder
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
    };

    # terminal
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "IosevkaTerm Nerd Font:size=11.5";
          "dpi-aware" = "yes";
          term = "foot";
        };

        colors = {
          cursor = "11111b f5e0dc";
          foreground = "cdd6f4";
          background = "1e1e2e";

          regular0 = "45475a";
          regular1 = "f38ba8";
          regular2 = "a6e3a1";
          regular3 = "f9e2af";
          regular4 = "89b4fa";
          regular5 = "f5c2e7";
          regular6 = "94e2d5";
          regular7 = "bac2de";

          bright0 = "585b70";
          bright1 = "f38ba8";
          bright2 = "a6e3a1";
          bright3 = "f9e2af";
          bright4 = "89b4fa";
          bright5 = "f5c2e7";
          bright6 = "94e2d5";
          bright7 = "a6adc8";

          "16" = "fab387";
          "17" = "f5e0dc";

          "selection-foreground" = "cdd6f4";
          "selection-background" = "414356";

          "search-box-no-match" = "11111b f38ba8";
          "search-box-match" = "cdd6f4 313244";

          "jump-labels" = "11111b fab387";
          urls = "89b4fa";
        };
      };
    };

    # shell
    programs.zsh = {
      enable = true;
      initContent = zshInitContent;
      autocd = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      # manual plugin management
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];

      shellAliases = {
        "gs" = "git status";
        "ls" = "eza";
        "cat" = "bat";
        "cd" = "z";
        "clear" = "";
        # to prevent the `clear` alias from interfering
        "cl" = "${pkgs.ncurses}/bin/clear -x";
        "rgv" = "rg --vimgrep ";
      };
    };
  };
}
