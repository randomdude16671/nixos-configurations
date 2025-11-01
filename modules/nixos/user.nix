{ pkgs, ... }:
{
  users = {
    users.ghost = {
      homeMode = "755";
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "libvirtd"
        "dialout" # arduino ide
        "lpadmin"
        "lp"
        "video"
        "input"
        "audio"
      ];
      useDefaultShell = true;
      packages = with pkgs; [ ];
    };
  };
  programs.nano.enable = false; # screw nano
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  age = {
    identityPaths = [ "/home/ghost/.agenix/agenix" ];
    secrets = {
      japan = {
        file = ../../secrets/japan.nmconnection.age;
        path = "/etc/NetworkManager/system-connections/japan.nmconnection";
        owner = "root";
        group = "root";
        mode = "0600";
      };

    };
  };
}
