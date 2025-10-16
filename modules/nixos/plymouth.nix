{ pkgs, ... }:
{
  boot.initrd.systemd.enable = true;
  boot.plymouth = {
    enable = true;
  };
  boot.kernelParams = [
    "quiet"
    "splash"
    "plymouth.use-simpledrm"
    "rd.system.show-status=false"
    "udev.log_priority=3"
    "loglevel=3"
  ];
}
