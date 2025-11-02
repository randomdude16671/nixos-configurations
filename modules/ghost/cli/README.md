# CLI configuration modules

> [!NOTE]
> **Most of these modules are inter-dependent, make sure you enable all of them.**

---

## default.nix 

Purpose: Recurse all files to create the whole cli module.

---

## enhancements.nix

> QoL shell enhancements

### dev.enhancements.enable

Enable some development enhancement tools

What it does:

- Sets DIRENV_WARN_TIMEOUT and EDITOR. (0 and nvim respectively)
- Enables bat as an alternative to cat (necessary for zsh config)
- Enables direnv && nix-direnv (auto nix-develop)
- Enables Zoxide (better cd)

---

## packages.nix

> Must-have CLI packages

### dev.packages.enable

Enables the installation of these packages:
```txt
opencode
vivid
duf
fd
gh
sesh
```

and installs any extra packages mentioned in extraPackages.

### dev.packages.extraPackages

appended to the list of packages that is normally installed.

---

## shell-scripts.nix

> Custom shell scripts that are put in $HOME/scripts 

### dev.scripts.enable

Enable Ghost's shell scripts.

---

## tmux.nix

> Tmux configuration.

### dev.tmux.enable

Enable Ghost's tmux configuration

What it does:
- Adds pkgs.tmux to home.packages
- Places proper tmux.conf in ~/.config/tmux/
- Places navigator plugin in ~/.config/tmux/

---

## zsh.nix

> Zsh configuration + Plugin management.

### dev.zsh.enable

Enable Ghost's Zsh configuration.

What it does: 
- Puts proper content in ~/.zshrc and ~/.zsh/
- Installs mentioned plugins and adds them to config

### dev.zsh.plugins

Plugins to be installed. 
Format of the plugins:

```nix
plugins = [
    {
        name = "name_of_plugin";
        src = pkgs.someZshPlugin;
        file = "share/someZshPlugin/fileToBeSourced.zsh";
    }
    # ...
];
```
