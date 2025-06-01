{pkgs, ...}: {
  services = {
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}
