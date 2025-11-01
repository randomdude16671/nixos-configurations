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
      intel-vaapi-driver
      libvdpau
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      intel-media-driver
    ];
  };
}
