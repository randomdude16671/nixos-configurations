{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gitFull
    dwt1-shell-color-scripts
    zed-editor
    gnupg
    # tip : always have a gui editor with a terminal
    # inside so you can still edit stuff if you accidentally delete your
    # terminal emulator, also include neovim in unstable flake.
    obsidian
    pamixer
    nixd
    foot
    alsa-utils
    gocryptfs
    man-pages
    man-pages-posix
    glow
  ];
  # for root
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
