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

  tmuxConf = builtins.concatStringsSep "\n" [
    "set-option -g default-shell ${pkgs.zsh}/bin/zsh"
    (builtins.readFile ./tmux.conf)
  ];
in {
  options.ghost.devTools.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable Ghost's Dev Tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Bat extensions
      bat-extras.batman
      bat-extras.batdiff
      bat-extras.batpipe

      # Normal packages
      bat
      hyperfine
      zk
      sesh
      zoxide
      btop
      fd
      foot
      arduino-ide
      eza
      gum
      tmux
      ripgrep
      gh
      dust
      duf
    ];

    home.file.".zsh/ctp_mocha.zsh".source = ./ctp_mocha.zsh;
    home.file.".zsh/git-aliases.zsh".source = ./git-zsh.zsh;

    home.sessionVariables = {
      DIRENV_WARN_TIMEOUT = 0;
      EDITOR = "nvim";
      ZVM_CURSOR_STYLE_ENABLED = "false";
    };

    xdg.configFile = {
      # terminal
      "tmux/tmux.conf".text = tmuxConf;
      "foot/foot.ini".source = ./foot.ini;

      # bat config and theme
      "bat/themes/Catppuccin_Mocha.tmTheme".source = ./catppuccin_bat.tmTheme;
      "bat/config".text = ''
        --theme='Catppuccin_Mocha'
        --pager='less -FR'
      '';

      # rofi config
      "rofi/config.rasi".source = ./rofi.rasi;
      "rofi/themes/catppuccin-mocha.rasi".source = ./ctp-rofi.rasi;
    };

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

    # shell
    programs.zsh = {
      enable = true;
      initContent = zshInitContent;
      autocd = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;

      # raw plugin management through Nix. No need for zinit, zplug or antidote (or anything similar)
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
        "volt" = "volt-build";
        "ls" = "eza";
        "cat" = "bat";
        "cd" = "z";
        "clear" = "";
        # to prevent the `clear` alias from interfering
        "cl" = "${pkgs.ncurses}/bin/clear -x";
        "grep" = "rg";
      };
    };
  };
}
