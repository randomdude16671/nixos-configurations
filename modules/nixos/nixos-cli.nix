{
  services.nixos-cli = {
    enable = true;
    config = {
      root_command = "doas";
      aliases = {
        genlist = [
          "generation"
          "list"
        ];
        rollback = [
          "generation"
          "rollback"
        ];
        gendel = [
          "generation"
          "delete"
        ];
        gendelall = [
          "generation"
          "delete"
          "--all"
        ];
        switch = [
          "apply"
          "-y"
        ];
      };

      apply = {
        imply_impure_with_tag = true;
        use_git_commit_msg = true;
        ignore_dirty_tree = true;
      };
    };
  };
}
