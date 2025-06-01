{pkgs, ...}: 
{
  home.packages = with pkgs; [ picom ]; 
  # just wrap the file in nix 
  xdg.configFile."picom.conf".source = ./picom.conf; 
}
