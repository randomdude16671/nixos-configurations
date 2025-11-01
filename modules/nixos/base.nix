{
  imports = [
    ./.
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # networking stuff
  networking = {
    hostName = "grimm";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # time zone (indian standard time)
  time.timeZone = "Asia/Kolkata";

  # the state version of the system (DO NOT CHANGE YET)
  system.stateVersion = "25.05";

}
