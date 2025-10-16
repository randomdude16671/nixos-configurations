{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = [
    pkgs.i3status
    pkgs.rofi
    pkgs.imv
    pkgs.wl-clipboard
    pkgs.proton-pass
    pkgs.imagemagick # for images in neovim and stuff
    pkgs.proton-authenticator
  ];
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };
  programs.btop.enable = true;

  gtk = {
    enable = true;
    theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "Catppuccin-GTK-Dark";
    };
  };
}
