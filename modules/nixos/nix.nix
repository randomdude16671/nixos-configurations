{
  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators" # vimjoyer's video says about this, its fire.
      ];
      trusted-users = [
        "@wheel"
        "root"
        "ghost"
      ];
    };
    gc = {
      dates = "weekly";
      automatic = true;
    };
  };
}
