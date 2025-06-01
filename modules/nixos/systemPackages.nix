{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gitFull
    zed-editor
    gnupg
    spotify
    # tip : always have a gui editor with a terminal
    # inside so you can still edit stuff if you accidentally delete your
    # terminal emulator, also include neovim in unstable flake.
    obsidian
    pamixer
    nil
    alacritty
    alsa-utils
    gocryptfs
  ];
  # for root
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
