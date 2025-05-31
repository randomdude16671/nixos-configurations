{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  home-manager.backupFileExtension = "hmBak";
  home-manager.users.ghost = {
    home.packages = with pkgs; [
      # all gui apps
      inputs.zen-browser.packages."${system}".beta
      ghostty
      authenticator
      i3status
      rofi
      vesktop
      nsxiv
      xclip
    ];
    imports = [
      ./modules/home-manager
      ./modules/ghost
    ];
    gtk.enable = true;
    # yes these are my own modules
    ghost = {
      devTools.enable = true;
      scripts.enable = true;
    };

    home.stateVersion = "24.11";
    programs.home-manager.enable = true; # let it cook bro.
  };
}
