{
  dconf = {
    enable = false;
  };

  # for stylix to generate theme for.
  programs.btop.enable = true;

  # cuztom stylix shitze.
  stylix.targets.qt.enable = true;
  stylix.targets.fzf.enable = false;
  stylix.targets.librewolf.profileNames = ["ghost"];
}
