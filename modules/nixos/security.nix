{
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "ghost" ];
          keepEnv = true;
          persist = true;
        }
        {
          users = [ "ghost" ];
          cmd = "vi";
          noPass = true;
        }
        {
          users = [ "ghost" ];
          cmd = "nvim";
          noPass = true;
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
