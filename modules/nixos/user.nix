{pkgs, ...}: {
  users = {
    users.ghost = {
      homeMode = "755";
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "dialout" # arduino ide
        "audio"
      ];
      useDefaultShell = true;
      packages = with pkgs; [];
    };
  };
  programs.nano.enable = false; # screw nano
  programs.zsh.enable = true;
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
}
