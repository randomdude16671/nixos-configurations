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
    glow
    nixfmt-rfc-style
    ripgrep
    mangohud
    ;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    gitFull
    gnupg
    alsa-utils
    ripgrep
    spotify
    gocryptfs
    man-pages
    nixd
    man-pages-posix
    glow
    nixfmt-rfc-style
    mangohud
  ];
}
