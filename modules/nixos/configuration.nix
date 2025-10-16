{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    ./.
  ];

  networking.hostName = "hydra";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "25.05";

}
