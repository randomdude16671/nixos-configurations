# devTools module for my developer tools; 
{config, lib, pkgs, ...}: 
with lib;

let cfg = config.ghost.devTools; 
  mini-build = pkgs.buildGoModule {
    pname = "mini-build";
    version = "0.1.0"; 

    src = pkgs.fetchFromGitHub {
      owner = "randomdude16671"; 
      repo = "mini-build"; 
      rev = "main"; 
      sha256 = "LIopYIm2sTrEhjtcXnXrtfleisJ5RBPiSD+ZZeXlQk4="; 
    };
    vendorHash = null; 
    meta = with lib; {
      description = "A super small build system written mainly for personal use."; 
      homepage = "https://github.com/randomdude16671/mini-build"; platforms = platforms.linux; 
      license = licenses.mit;
    }; 
  };
in
{
  options.ghost.devTools.enable = lib.mkOption {
    type = lib.types.bool; 
    default = false; 
    description = "Enable Ghost's Dev Tools.";  
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      mini-build 
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
      tmux
      ripgrep
      gh
    ]; 

    # smart cd command 
    programs.zoxide = {
      enable = true; 
      enableZshIntegration = true; 
    }; 

    home.file.".zsh/ctp_mocha.zsh".source = ./ctp_mocha.zsh; 

    xdg.configFile = {
      # terminal 
      "ghostty/config" = {
        source = ./ghostty-config; 
      }; 
      # multiplexer
      "tmux/tmux.conf" = {
        source = ./tmux.conf; 
      }; 

      # cat alternative 
      "bat/themes/Catppuccin_Mocha.tmTheme" = {
        source = ./catppuccin_bat.tmTheme; 
      }; 

      "bat/config" = {
        text = '' 
        --theme='Catppuccin_Mocha'
        ''; 
      }; 
    };

    # for auto dev-shell (i use) 
    programs.direnv = {
      enable = true; 
      enableZshIntegration = true;
      silent = true; 
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
      oh-my-zsh = {
        enable = true; 
        theme = "robbyrussell"; 
        plugins = [ "git" "sudo" ]; 
      }; 
      initExtra = '' 
        bindkey -v 
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
      ''; 
      syntaxHighlighting.enable = true; 
      autocd = true; 
      shellAliases = {
        "gs" = "git status"; 
        "mb" = "mini-build"; 
        "cat" = "bat"; 
        "cd" = "z"; 
        "cl" = "clear -x"; # -x keeps the scrollback
        "vi" = "nvim"; 
        "vim" = "nvim"; 
        "grep" = "rg"; 
      };
    }; 
  }; 
}
