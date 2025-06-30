{pkgs, ...}: {
  users = {
    users.ghost = {
      homeMode = "755";
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "libvirtd"
        "dialout" # arduino ide
        "audio"
      ];
      useDefaultShell = true;
      hashedPassword = "$6$O/zYxMSofNw/wPbg$1bz4AMkmCbN/ttEWtwM/B5UiQVQ1KKkNN4XZznpZrMdA/OmV7KNUOC36r9vB/QLGH7wqyuHyj8/JEo1UFkKAV.";
      packages = with pkgs; [];
    };
  };
  programs.nano.enable = false; # screw nano
  programs.zsh.enable = true;
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
}
