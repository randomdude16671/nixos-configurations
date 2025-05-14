{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [maim i3-auto-layout];
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      fonts = {
        names = ["ZedMono Nerd Font"];
        style = "Regular";
      };
      startup = [
        {
          command = "--no-startup-id setxkbmap 'caps:swapescape'";
          always = true;
        }
        {
          command = "--no-startup-id /home/ghost/scripts/i3-tile.sh";
          always = true;
        }
      ];
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec ghostty";
          "${modifier}+t" = "layout tabbed";
          "${modifier}+b" = "exec zen";
          "${modifier}+d" = "exec rofi -show drun";
          "${modifier}+Shift+S" = "exec maim -s | xclip -selection clipboard -t image/png";
          "${modifier}+s" = "exec maim -s ~/foo.png";
          "XF86AudioRaiseVolume" = "exec pamixer --increase 5";
          "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
          "${modifier}+w" = "kill";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+o" = "exec rofi -show window";
        };
      defaultWorkspace = "workspace number 1";
      bars = [];

      window = {
        border = 2;
        titlebar = false;
      };
    };
    extraConfig = ''
      bar {
        font pango:ZedMono Nerd Font 10
        mode dock
        hidden_state hide
        position bottom
        status_command /nix/store/s1g5xragmhfynvkss43fsxk22zkhm9lf-i3status-2.15/bin/i3status
        i3bar_command /nix/store/g4frpvn0jp6hhkrjmc7z0s4nrz30rdnn-i3-4.24/bin/i3bar
        workspace_buttons yes
        strip_workspace_numbers no
        tray_output primary
        colors {
          background #000000
          statusline #ffffff
          separator #666666
          focused_workspace #4c7899 #285577 #ffffff
          active_workspace #333333 #5f676a #ffffff
          inactive_workspace #333333 #222222 #888888
          urgent_workspace #2f343a #900000 #ffffff
          binding_mode #2f343a #900000 #ffffff
        }
      }
      exec_always --no-startup-id i3-auto-layout
    '';
  };
}
