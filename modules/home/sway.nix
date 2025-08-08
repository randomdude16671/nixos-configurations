{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    slurp
    grim
    swappy
    autotiling-rs
    brightnessctl
    playerctl
    i3status
  ];
  wayland.windowManager.sway = {
    enable = true;
    config = {
      startup = [
        {
          command = "~/scripts/swayidle.sh";
          always = true;
        }
        {
          command = "swaync &";
          always = true;
        }
        {
          command = "swayosd-server";
          always = true;
        }
        {
          command = "${pkgs.foot}/bin/foot --server &";
          always = true;
        }
        {
          command = "autotiling-rs";
          always = true;
        }
      ];
      input = {
        "*" = {
          xkb_options = "caps:swapescape";
        };
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "40";
        };
      };
      modifier = "Mod4";
      fonts = {
        names = [ "Iosevka Term Nerd Font" ];
        style = "Regular";
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec footclient";
          "${modifier}+t" = "layout tabbed";
          "${modifier}+b" = "exec librewolf";
          "${modifier}+d" = "exec rofi -show drun";
          "${modifier}+Shift+S" = "exec ~/scripts/maim.sh";
          "${modifier}+Shift+D" = "exec ~/scripts/swappy.sh";
          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume +5";
          "XF86AudioLowerVolume" = "exec swayosd-client --output-volume -5";
          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "XF86MonBrightnessUp" = "exec swayosd-client --brightness +5";
          "XF86MonBrightnessDown" = "exec swayosd-client --brightness -5";
          "XF86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";
          "${modifier}+Shift+n" = "exec playerctl next";
          "${modifier}+Shift+p" = "exec playerctl previous";
          "${modifier}+p" = "exec swaync-client -t"; # open panel/close panel
          "${modifier}+w" = "kill";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+s" = "layout stacking";
        };
      defaultWorkspace = "workspace number 1";
      bars = [ ];

      window = {
        border = 2;
        titlebar = false;
      };
    };
    extraConfig = ''
      bar {
        font pango:Iosevka Term Nerd Font 11
        mode dock
        hidden_state hide
        position bottom
        status_command i3status
        strip_workspace_numbers no
        tray_output primary
        colors {
          background #11111b
          statusline #ffffff
          separator #666666
          focused_workspace #4c7899 #285577 #ffffff
          active_workspace #333333 #5f676a #ffffff
          inactive_workspace #333333 #222222 #888888
          urgent_workspace #2f343a #900000 #ffffff
          binding_mode #2f343a #900000 #ffffff
        }
      }
    '';
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
