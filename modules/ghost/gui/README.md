# GUI configuration modules.

> [!NOTE]
> **Most of these modules are inter-dependent, make sure you enable all of them.**

---

## browser.nix

> Management for the zen browser 

### browser.enable

Enable Ghost's browser configurations (zen browser)

### browser.extensions

List of extensions to install (package), normally taken from rycee's NUR expressions

---

## fuzzel.nix

> fuzzel configuration for Ghost (app launcher)

### fuzzel.enable

Install fuzzel to home.packages, and puts configuration of fuzzel in the right spot.

---

## terminal.nix

> Foot configurations for Ghost (terminal)

> [!NOTE]
> This is namespaced under dev because terminals are usually used by developers (makes more sense)

### dev.terminal.enable 

Enable Ghost's foot configuration

### dev.terminal.extraConfig

Extra lines of configuration for the foot terminal (type = str concatenated with \n)

---

## vesktop.nix

> Discord client customization and configuration.

### vesktop.enable 

Enable Ghost's vesktop configurations

### vesktop.useSystem

Use the vencord package from nixpkgs.

> [!NOTE]
> **Default is `true`**
 
---
