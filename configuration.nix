{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/nixos
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
  ];
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  fonts.fontconfig.antialias = true;
  system.stateVersion = "24.11";
}
