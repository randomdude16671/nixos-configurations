{
  config,
  pkgs,
  inputs,
  ...
}:
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.iosevka-term;
      name = "IosevkaTerm Nerd Font";
    };
    sansSerif = {
      package = pkgs.adwaita-fonts;
      name = "Adwaita Sans";
    };
    serif = {
      package = pkgs.adwaita-fonts;
      name = "Adwaita Sans";
    };
  };
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  stylix.autoEnable = true;
  stylix.image = ../wallpapers/after.png;
  stylix.polarity = "dark";
}
