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
      bat-extras.batman
      bat-extras.batdiff
      bat-extras.batpipe
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
      "foot/foot.ini".source = ./terminal/foot.ini;

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
