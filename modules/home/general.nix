{ pkgs, ... }:
{
  home.packages = [
    pkgs.i3status
    pkgs.rofi-wayland
    pkgs.nixd
    pkgs.imv
    pkgs.wl-clipboard
    pkgs.proton-pass
    pkgs.proton-authenticator
    pkgs.zed-editor
    pkgs.notesnook
  ];
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
  };
  programs.btop.enable = true;

  # cuztom stylix shitze.
  stylix = {
    targets = {
      qt.enable = true;
      fzf.enable = false;
      librewolf.profileNames = [ "ghost" ];
      foot.enable = false;
    };
  };
}
