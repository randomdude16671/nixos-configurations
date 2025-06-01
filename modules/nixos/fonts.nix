{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      dejavu_fonts
      nerd-fonts.jetbrains-mono
      noto-fonts-emoji
    ];
    fontconfig = {
      antialias = true;
      defaultFonts = {
        serif = ["JetBrainsMono Nerd Font"];
        sansSerif = ["JetBrainsMono Nerd Font"];
        monospace = ["Iosevka Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
