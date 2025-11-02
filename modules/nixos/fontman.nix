{
  pkgs,
  ...
}:
{
  fontman = {
    enable = true;
    fonts = {
      serif = {
        name = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
      };
      sansSerif = {
        name = "Adwaita Sans";
        package = pkgs.adwaita-fonts;
      };
      monospace = {
        name = "IosevkaTerm Nerd Font";
        package = pkgs.nerd-fonts.iosevka-term;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
    };
    extraPackages =
      let
        inherit (pkgs) nerd-fonts;
      in
      [
        nerd-fonts.geist-mono
      ];
  };
}
