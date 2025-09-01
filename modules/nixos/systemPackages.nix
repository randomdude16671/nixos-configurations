{
  pkgs,
  inputs,
  ...
}:
let
  inherit (pkgs)
    gitFull
    gnupg
    alsa-utils
    spotify
    gocryptfs
    man-pages
    nixd
    man-pages-posix
    lapce
    glow
    ;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    # tip : always have a gui editor with a terminal
    # inside so you can still edit stuff if you accidentally delete your
    # terminal emulator (lapce is the editor in this list)
    gitFull
    gnupg
    alsa-utils
    spotify
    gocryptfs
    man-pages
    nixd
    man-pages-posix
    lapce
    glow
  ];
}
