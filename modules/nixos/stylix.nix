{
  config,
  pkgs,
  ...
}: {
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.iosevka-term;
      name = "IosevkaTerm Nerd Font";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    serif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
  };
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  stylix.autoEnable = true;
  stylix.image = ../wallpapers/after.png; # goodbye to.jpg (I used that exact file for years)
  stylix.polarity = "dark";
}
