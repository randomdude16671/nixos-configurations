{
pkgs,
inputs,
...
}: {
  home-manager.backupFileExtension = "hmBak";
  home-manager.users.ghost = {
    home.packages = with pkgs; [
      # all gui apps 
      inputs.zen-browser.packages."${system}".beta
      inputs.ghostty.packages.${system}.default
      rofi
      authenticator
      i3status
      vesktop
      nsxiv
      xclip
    ];
    imports = [
      ./modules/home-manager
      ./modules/ghost
    ];
    ghost.devTools.enable = true;  
    home.stateVersion = "24.11";
    programs.home-manager.enable = true; # let it cook bro.
  };
}
