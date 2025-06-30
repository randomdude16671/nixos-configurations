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
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-users = [
        "root"
        "ghost"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
