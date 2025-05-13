{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gitFull
    xorg.xinit
    xorg.libX11
    spotify
    neovim
    zed-editor
    # tip : always have a gui editor with a terminal
    # inside so you can still edit stuff if you accidentally delete your
    # terminal emulator
    obsidian
    pamixer
    nixd
    alsa-utils
  ];
}
