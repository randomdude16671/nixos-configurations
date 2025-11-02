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
    gocryptfs
    man-pages
    nixd
    man-pages-posix
    glow
    nixfmt-rfc-style
    ripgrep
    mangohud
    lsof
    ;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    gitFull
    gnupg
    alsa-utils
    ripgrep
    gocryptfs
    man-pages
    nixd
    man-pages-posix
    glow
    nixfmt-rfc-style
    mangohud
    lsof
  ];
}
