{
  pkgs,
  config,
  ...
}: {
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    mesa
    vaapiIntel
    vaapiVdpau
    libvdpau
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    intel-media-driver
  ];

  hardware.graphics.extraPackages32 = with pkgs; [
    mesa.drivers
  ];
}
