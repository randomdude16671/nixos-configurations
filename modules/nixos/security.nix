{
  pkgs,
  ...
}:
{
  services.dbus.apparmor = "enabled";
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    auditd.enable = true;
    audit.backlogLimit = 8192;
    apparmor = {
      enable = true;
      enableCache = true;
      killUnconfinedConfinables = false;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "ghost" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    pam = {
      services = {
        ly.enableGnomeKeyring = true;
      };
    };
  };
}
