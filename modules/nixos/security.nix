{
  security.rtkit.enable = true;
  security = {
    pam = {
      services = {
        ly.enableGnomeKeyring = true;
      };
    };
  };
}
