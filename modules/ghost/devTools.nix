# devTools module for my developer tools;
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.ghost.devTools;
in {
  options.ghost.devTools.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Ghost's Dev Tools.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
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
      initContent = ''
        bindkey -v
				PATH="$PATH:/home/ghost/.local/bin/" 
        source ~/.zsh/ctp_mocha.zsh
        export FZF_DEFAULT_OPTS=" \
        --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
        --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
        --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
        --color=selected-bg:#45475A \
        --color=border:#313244,label:#CDD6F4"
        . <(fzf --zsh)

        bindkey -s '^k' "~/scripts/sesh_start.sh\n"
        bindkey -sv '^k'  "~/scripts/sesh_start.sh\n"
        source ~/.zsh/git-aliases.zsh

        autoload -Uz vcs_info

        zstyle ':vcs_info:git:*' formats '%F{blue}git:(%F{red}%b%F{blue})%f %u%c'
        zstyle ':vcs_info:git:*' actionformats '%F{blue}git:(%F{red}%b|%a%F{blue})%f %u%c'
        zstyle ':vcs_info:git:*' check-for-changes true

        zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}✗%f '
        zstyle ':vcs_info:git:*' stagedstr '%F{green}✓%f '

        zstyle ':vcs_info:*' enable git

        precmd() { vcs_info }

        prompt_dir() {
          if [[ -n "$TMUX" ]]; then
            echo "%F{cyan}%B$(basename $PWD)%b%f"
          else
            echo "%F{cyan}%B%c%b%f"
          fi
        }

        prompt_arrow() {
          [[ $? -eq 0 ]] && echo "%F{green}>%f" || echo "%F{red}<%f"
        }

        setopt PROMPT_SUBST

        PROMPT=' $(prompt_arrow)  $(prompt_dir) ''${vcs_info_msg_0_}'
      '';

      syntaxHighlighting.enable = true;
      autocd = true;
      shellAliases = {
        "gs" = "git status";
        "mb" = "mini-build";
        "ls" = "eza";
        "cat" = "bat";
        "cd" = "z";
        "cl" = "clear";
        "vi" = "nvim";
        "vim" = "nvim";
        "grep" = "rg";
      };
    };
  };
}
