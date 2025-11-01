{ pkgs, ... }:
{
  programs.sway = {
    enable = true;
    package = pkgs.sway;
    xwayland.enable = true;
  };
  services.displayManager = {
    ly = {
      enable = true;
    };
  };
}
