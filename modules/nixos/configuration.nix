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
    ./.
  ];

  networking.hostName = "hydra";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "25.05";
}
