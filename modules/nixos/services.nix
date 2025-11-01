{ pkgs, ... }:
{
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        UsePAM = true;
        PasswordAuthentication = false;
      };
    };
    gnome.gnome-keyring.enable = true;
  };
}
