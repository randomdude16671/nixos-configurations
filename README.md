# NixOS configurations for Ghost (randomdude16671)

- Hostname is `hydra`
- Only user in configuration is `ghost`

---

## Config Layout

- `modules/nixos` – System-level NixOS modules
- `modules/home` – Home-manager modules
- `modules/ghost` – Custom config modules (shell, terminal, etc)
- `modules/scripts` – Shell scripts used in `ghost`
- `modules/wallpapers` – Backgrounds for use.

> *Note: you'll see the nickname `ghost` used throughout this config. It's mine.*

---

## System Info

| Tool            | Description                      |
|-----------------|----------------------------------|
| OS              | NixOS Unstable (flakes)          |
| WM              | Sway + autotiling-rs (master stack) |
| Terminal        | Kitty               |
| Theme           | Catppuccin Mocha       |
| Font            | Iosevka Term Nerd Font                     |
| Shell           | Zsh (no framework, fully custom) |
| App Launcher    | Rofi                             |
| Lock Screen     | swaylock-effects                 |
| Editor          | Neovim (LSP, tree-sitter)        |

---

## Configuration layout in tree format: 

```bash
.
├── flake.lock
├── flake.nix
├── ghost.nix
├── modules
│   ├── ghost
│   │   ├── browser.nix
│   │   ├── default.nix
│   │   ├── dev.nix
│   │   ├── rofi
│   │   │   ├── rofi.rasi
│   │   │   └── wallpapers.sh
│   │   ├── shell-scripts.nix
│   │   ├── terminal.backups
│   │   │   ├── foot.ini
│   │   │   └── ghostty.conf
│   │   ├── tmux
│   │   │   ├── tmux.conf
│   │   │   └── vim-tmux-navigator.tmux
│   │   ├── vesktop.nix
│   │   └── zsh
│   │       ├── async.zsh
│   │       ├── ctp-mocha.zsh
│   │       ├── git-zsh.zsh
│   │       ├── init-content.zsh
│   │       └── specter.zsh-theme
│   ├── home
│   │   ├── bar.nix
│   │   ├── default.nix
│   │   ├── general.nix
│   │   ├── swaync.nix
│   │   ├── sway.nix
│   │   └── waybar
│   │       ├── config.json
│   │       └── style.css
│   ├── nixos
│   │   ├── bluetooth.nix
│   │   ├── boot.nix
│   │   ├── catppuccin.nix
│   │   ├── configuration.nix
│   │   ├── default.nix
│   │   ├── dm-de.nix
│   │   ├── fontman.nix
│   │   ├── gnupg.nix
│   │   ├── hardware-configuration.nix
│   │   ├── hardware.nix
│   │   ├── locale-things.nix
│   │   ├── man.nix
│   │   ├── nix.nix
│   │   ├── pipewire-wireplumber.nix
│   │   ├── plymouth.nix
│   │   ├── security.nix
│   │   ├── some-services.nix
│   │   ├── steam.nix
│   │   ├── syncthing.nix
│   │   ├── systemPackages.nix
│   │   ├── user.nix
│   │   └── virtualization.nix
│   ├── pkgs
│   │   └── catppuccin-mocha.nix
│   ├── scripts
│   │   ├── i3-tile.sh
│   │   ├── install_neovim.sh
│   │   ├── lock.sh
│   │   ├── maim.sh
│   │   ├── rebuild.sh
│   │   ├── sesh_session_switch.sh
│   │   ├── sesh_start.sh
│   │   ├── speedfiles.sh
│   │   ├── swappy.sh
│   │   └── swayidle.sh
│   └── wallpapers
│       ├── after.png
│       ├── castle.png
│       ├── clouds.jpg
│       ├── evening.png
│       ├── gradient.png
│       ├── nightClouds.jpg
│       ├── nix.png
│       ├── romb.png
│       ├── to.jpg
│       ├── warrior.png
│       └── waves.png
├── README.md
├── screenshots
│   └── latest.png
└── secrets
    ├── japan.nmconnection.age
    └── secrets.nix

15 directories, 74 files
```

