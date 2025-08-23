# Hydra (Hostname and what I call this configuration) 

> A clean, minimal, fully declarative NixOS + Sway config with <400MB RAM idle usage.  
> Designed for speed, full control, and zero bloat.

![Hydra in action](screenshots/latest.png)

---

## Config Layout

- `modules/nixos` – System-level NixOS modules
- `modules/home` – Home-manager modules
- `modules/ghost` – Custom config modules (shell, terminal, etc)
- `modules/scripts` – Shell scripts used in `ghost`
- `modules/wallpapers` – Backgrounds for use with Stylix

> *Note: you'll see the nickname `ghost` used throughout this config. It's mine.*

---

## System Info

| Tool            | Description                      |
|-----------------|----------------------------------|
| OS              | NixOS Unstable (flakes)          |
| WM              | Sway + autotiling-rs (master stack) |
| Terminal        | Foot (daemon-mode)               |
| Theme           | Catppuccin Mocha via Stylix      |
| Font            | Iosevka Term Nerd Font                     |
| Shell           | Zsh (no framework, fully custom) |
| App Launcher    | Rofi                             |
| Lock Screen     | swaylock-effects                 |
| Editor          | Neovim (LSP, tree-sitter)        |

---

## Configuration layout in tree format: 

```bash
tree
.
├── flake.lock
├── flake.nix
├── ghost.nix
├── modules
│   ├── ghost
│   │   ├── bat
│   │   │   └── catppuccin.tmTheme
│   │   ├── default.nix
│   │   ├── dev.nix
│   │   ├── librewolf.nix
│   │   ├── rofi
│   │   │   ├── ctp-rofi.rasi
│   │   │   └── rofi.rasi
│   │   ├── shell-scripts.nix
│   │   ├── terminal
│   │   │   └── foot.ini
│   │   ├── tmux
│   │   │   └── tmux.conf
│   │   └── zsh
│   │       ├── ctp_mocha.zsh
│   │       ├── git-zsh.zsh
│   │       └── initContent.zsh
│   ├── home
│   │   ├── default.nix
│   │   ├── general.nix
│   │   ├── swaync.nix
│   │   ├── swaync-style.css
│   │   └── sway.nix
│   ├── nixos
│   │   ├── bluetooth.nix
│   │   ├── boot.nix
│   │   ├── configuration.nix
│   │   ├── default.nix
│   │   ├── dm-de.nix
│   │   ├── fonts.nix
│   │   ├── gnupg.nix
│   │   ├── hardware-configuration.nix
│   │   ├── hardware.nix
│   │   ├── locale-things.nix
│   │   ├── man.nix
│   │   ├── nix.nix
│   │   ├── pipewire-wireplumber.nix
│   │   ├── printing.nix
│   │   ├── security.nix
│   │   ├── some-services.nix
│   │   ├── stylix.nix
│   │   ├── syncthing.nix
│   │   ├── systemPackages.nix
│   │   ├── user.nix
│   │   └── virtualization.nix
│   ├── scripts
│   │   ├── i3-tile.sh
│   │   ├── install_neovim.sh
│   │   ├── lock.sh
│   │   ├── maim.sh
│   │   ├── rebuild.sh
│   │   ├── sesh_start.sh
│   │   ├── speedfiles.sh
│   │   ├── swappy.sh
│   │   └── swayidle.sh
│   └── wallpapers
│       ├── after.png
│       └── to.jpg
├── README.md
└── screenshots
    └── latest.png

13 directories, 54 files
```
