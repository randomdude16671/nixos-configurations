{
  services.syncthing = {
    enable = true;
    user = "ghost";
    dataDir = "/home/ghost";
    openDefaultPorts = true;
  };
}
