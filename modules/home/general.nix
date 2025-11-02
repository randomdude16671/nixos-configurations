{
  pkgs,
  lib,
  config,
  ...
}:
{
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "Catppuccin-GTK-Dark";
    };
  };

  home.file.".config/nvim" = {
    source = ../nvim; 
    recursive = true;
  };
}
