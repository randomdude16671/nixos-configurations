{pkgs, ...}: {
  dconf = {
    enable = false;
  };

  gtk = {
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
  };

  # for stylix to generate theme for.
  programs.btop.enable = true;

  # cuztom stylix shitze.
  stylix = {
    targets = {
      qt.enable = true;
      fzf.enable = false;
      librewolf.profileNames = ["ghost"];
    };
  };
}
