{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ghost.dev;

  tmuxConf = builtins.concatStringsSep "\n" [
    "set-option -g default-shell ${pkgs.zsh}/bin/zsh"
    "set-option -g default-command '${pkgs.zsh}/bin/zsh -l'"
    (builtins.readFile ./tmux/tmux.conf)
  ];
in
{
  options.ghost.dev.enable = mkEnableOption "Enable Ghost's dev tools";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      arduino-ide
      bat
      btop
      duf
      fd
      gh
      hyperfine
      sesh
      tmux
      zoxide
      swaybg
    ];

    programs.bat.enable = true;
    home.file = {
      ".zsh/ctp-mocha.zsh".source = ./zsh/ctp-mocha.zsh;
      ".zsh/git-aliases.zsh".source = ./zsh/git-zsh.zsh;
      ".zsh/specter.zsh-theme".source = ./zsh/specter.zsh-theme;
      ".zsh/deps/async.zsh".source = ./zsh/async.zsh;
    };

    home.sessionVariables = {
      DIRENV_WARN_TIMEOUT = 0;
      EDITOR = "nvim";
      ZVM_CURSOR_STYLE_ENABLED = "false";
      GTK_THEME = "adw-gtk3";
    };

    xdg.configFile = {
      "tmux/tmux.conf".text = tmuxConf;
      "tmux/navigator.tmux" = {
        source = ./tmux/vim-tmux-navigator.tmux;
        executable = true;
      };
      "rofi/config.rasi".source = ./rofi/rofi.rasi;
    };

    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        silent = false;
        nix-direnv.enable = true;
      };

      zoxide.enableZshIntegration = true;
      zoxide.enable = true;

      fzf = {
        enable = true;
        enableZshIntegration = true;
        tmux.enableShellIntegration = true;
      };

      eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
        colors = "always";
      };

      kitty = {
        enable = true;
        font = {
          name = "IosevkaTerm Nerd Font";
          package = pkgs.nerd-fonts.iosevka-term;
          size = 16;
        };
        settings = {
          enable_audio_bell = false;
          background_opacity = 0.9;
          background_blur = 1;
        };
        shellIntegration = {
          enableZshIntegration = true;
        };
        enableGitIntegration = true;
        themeFile = "Catppuccin-Mocha";
      };
      zsh = {
        enable = true;
        initContent = builtins.readFile ./zsh/init-content.zsh;
        autocd = true;
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;

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
          gs = "git status";
          cat = "bat";
          cd = "z";
          clear = "";
          ls = "eza";
          cl = "${pkgs.ncurses}/bin/clear -x";
          rgv = "rg --vimgrep ";
        };
      };
    };
  };
}
