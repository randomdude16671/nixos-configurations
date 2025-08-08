{
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gitFull
    gnupg
    # tip : always have a gui editor with a terminal
    # inside so you can still edit stuff if you accidentally delete your
    # terminal emulator, also include neovim in unstable flake.
    alsa-utils
    spotify
    gocryptfs
    man-pages
    nixd
    man-pages-posix
    glow
  ];
}
