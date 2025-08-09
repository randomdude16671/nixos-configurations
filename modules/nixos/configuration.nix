{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-cli.nixosModules.nixos-cli
    ./.
  ];

  networking.hostName = "hydra";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "25.05";
}
