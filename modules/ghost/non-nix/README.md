# non-nix/

> [!NOTE]
> **This directory is not 'negative' or bad in anyway, it's just a collection of files I don't like to mix with nix files**

---

## tmux/

### tmux.conf

main configuration for tmux, this file has to strings concatenated in it in the actual use, it's used in this format:

```nix
# file: cli/tmux.nix
xdg.configFile."tmux/tmux.conf".text = builtins.concatStringsSep "\n" [
  "set-option -g default-shell ${pkgs.zsh}/bin/zsh"
  "set-option -g default-command '${pkgs.zsh}/bin/zsh -l'"
  (builtins.readFile ../non-nix/tmux/tmux.conf)
];
```

for dynamic absolute path decision through Nix. (so it always points to right nix store path)

### vim-tmux-navigator.tmux

plugin fetched from GitHub to make sure that I can navigate between neovim and tmux panes seamlessly
used like:

```nix
# file: cli/tmux.nix
"tmux/navigator.tmux" = {
    source = ../non-nix/tmux/vim-tmux-navigator.tmux;
    executable = true;
};
```

---

## rofi/

### rofi.rasi

main configuration for rofi, used in this format:

```nix
# file: gui/rofi.nix
xdg.configFile."rofi/config.rasi".source = ../non-nix/rofi/rofi.rasi;
```

### wallpapers.sh

shell script to make a rofi launcher to switch wallpapers 
used like:

```nix
"scripts/wallpapers.sh" = {
    source = ../non-nix/rofi/wallpapers.sh;
    executable = true;
};
```

