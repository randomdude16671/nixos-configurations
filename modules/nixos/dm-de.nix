{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true; # configuration handled by home-manager.
    excludePackages = [ pkgs.xterm ];
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:swapescape";
    };
  };
  services.displayManager.ly.enable = true;
}
