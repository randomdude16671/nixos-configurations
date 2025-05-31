{
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gitFull
    xorg.xinit
    xorg.libX11
    zed-editor
    gnupg
    spotify
    # tip : always have a gui editor with a terminal
    # inside so you can still edit stuff if you accidentally delete your
    # terminal emulator, also include neovim in unstable flake.
    obsidian
    pamixer
    nixd
    alsa-utils
    gocryptfs
  ];
}
