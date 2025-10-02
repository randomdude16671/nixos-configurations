{
  pkgs,
  config,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      vaapiIntel
      vaapiVdpau
      libvdpau
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      intel-media-driver
    ];
  };
}
