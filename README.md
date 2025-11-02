# Ghost's NixOS Configuration

> [!NOTE]
> **This entire README is AI generated through OpenCode Zen Code Supernova 1M, as an experiment**

A modular, declarative NixOS configuration with Home Manager integration for a personalized Linux desktop experience.

## 🏗️ Overview

This configuration uses Nix flakes to manage a complete system setup for the `grimm` host, featuring:
- **Modular architecture** with separate concerns for system, home, and application configurations
- **Home Manager integration** for user-level configuration management
- **Catppuccin theme** throughout the system
- **Wayland/Sway** desktop environment with custom bar and notifications
- **Development-focused** CLI tools and GUI applications

## 📁 Structure

```
config/
├── flake.nix              # Main flake definition
├── ghost.nix              # Home Manager user configuration
├── modules/
│   ├── nixos/             # System-level modules
│   │   ├── base.nix       # Base system configuration
│   │   ├── desktop.nix    # Desktop environment (Sway)
│   │   ├── audio.nix      # Audio configuration (PipeWire)
│   │   ├── bluetooth.nix  # Bluetooth support
│   │   ├── packages.nix   # System packages
│   │   └── ...
│   ├── home/              # Home Manager modules
│   │   ├── waybar/        # Wayland bar config
│   │   ├── sway.nix       # Sway window manager
│   │   ├── swaync.nix     # Notification daemon
│   │   └── ...
│   └── ghost/             # Custom application modules
│       ├── cli/           # Command-line tools
│       ├── gui/           # GUI applications
│       └── non-nix/       # Traditional config files
├── scripts/               # Utility scripts
├── wallpapers/            # Background images
└── secrets/              # Encrypted secrets (agenix)
```

## 🚀 Features

### System Configuration
- **NixOS Unstable** track with automatic updates
- **Wayland + Sway** tiling window manager
- **PipeWire** audio stack with Bluetooth support
- **Catppuccin** system-wide theme
- **Gnupg** encryption setup
- **Syncthing** file synchronization
- **Steam** gaming support

### Development Environment
- **Neovim** nightly build as default editor
- **Zsh** with custom plugins and theme
- **Tmux** terminal multiplexer with vim-navigator
- **Foot** terminal emulator
- **Direnv + nix-direnv** for development environments
- **Git** with GitHub CLI integration

### GUI Applications
- **Zen Browser** with privacy extensions
- **Vesktop** Discord client
- **Fuzzel** application launcher
- **Waybar** customizable status bar
- **SwayNotificationCenter** notification daemon

### CLI Tools
Essential packages including:
- `opencode`, `vivid`, `duf`, `fd`, `gh`, `sesh`
- `bat`, `zoxide`, `wl-clipboard`
- Custom shell scripts for screenshots, wallpapers, and session management

## Configuration

### System Modules
System modules are located in `modules/nixos/` and are automatically imported. Key modules include:

- `base.nix` - Locale, networking, timezone
- `desktop.nix` - Sway, Wayland, display management
- `audio.nix` - PipeWire, PulseAudio compatibility
- `packages.nix` - System-wide packages

### Home Configuration
User configuration is defined in `ghost.nix` with the following structure:

```nix
ghost = {
  dev = {
    enhancements.enable = true;
    packages.enable = true;
    scripts.enable = true;
    tmux.enable = true;
    terminal.enable = true;
    zsh.enable = true;
  };
  browser.enable = true;
  fuzzel.enable = true;
  vesktop.enable = true;
};
```

### Custom Modules
The `modules/ghost/` directory contains custom application modules:

#### CLI Modules (`modules/ghost/cli/`)
- **Enhancements**: QoL shell tools (direnv, zoxide, bat)
- **Packages**: Essential CLI utilities
- **Shell Scripts**: Custom scripts in `~/scripts/`
- **Tmux**: Terminal multiplexer configuration
- **Zsh**: Shell with plugin management

#### GUI Modules (`modules/ghost/gui/`)
- **Browser**: Zen Browser with extensions
- **Fuzzel**: Application launcher
- **Terminal**: Foot terminal configuration
- **Vesktop**: Discord client customization

##  Theming

The configuration uses the **Catppuccin** theme across:
- System GTK/Qt applications
- Terminal color schemes
- Waybar styling
- Sway decorations

##  Secrets

Sensitive configuration is managed with **agenix**:
- Network connection secrets
- GPG keys
- Authentication tokens

Secrets are stored in `secrets/` as encrypted `.age` files.

##  Scripts

Custom scripts in `scripts/`:
- `rebuild.sh` - System rebuild helper
- `lock.sh` - Screen locker
- `maim.sh` - Screenshot utility
- `wallpapers.sh` - Wallpaper switcher
- `sesh_*.sh` - Session management

##  Flake Inputs

This configuration uses several community flakes:
- `nixpkgs/nixos-unstable` - Main package repository
- `home-manager` - User configuration management
- `catppuccin/nix` - System theming
- `agenix` - Secret management
- `neovim-nightly-overlay` - Latest Neovim
- `nur` - Nix User Repository
- `zen-browser-flake` - Privacy-focused browser
- `fontman` - Font management

##  Contributing

This is a personal configuration, but feel free to:
- Fork and adapt for your own use
- Open issues for questions
- Submit pull requests for improvements

## License

Public Domain
