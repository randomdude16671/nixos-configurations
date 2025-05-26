{
  config,
  pkgs,
  ...
}: {
  stylix.enable = true;
  stylix.base16Scheme = ../themes/catppuccin-mocha.yaml;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.iosevka;
      name = "Iosevka Nerd Font";
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
  stylix.image = ../wallpapers/to.jpg;
  stylix.polarity = "dark";
}

