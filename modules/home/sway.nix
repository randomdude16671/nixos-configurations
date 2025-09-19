{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    slurp # select screen regions like a pro
    grim # screenshots, but grim
    swappy # annotate like you mean it
    autotiling-rs # because manual tiling is for people with too much time
    brightnessctl # control the brightness like a masochist
    playerctl # music control for people too focused to move to different workspaces
    i3status # bottom bar filler so it’s not lonely
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      # Autostart programs; yes, these **will** eat your RAM  (that's why theres only 5)
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
          command = "${pkgs.foot}/bin/foot --server";
          always = true;
        }
        {
          command = "swayosd-server";
          always = true;
        }
        {
          command = "autotiling-rs";
          always = true;
        }
      ];

      # Input settings; swap caps/escape because Vim supremacy
      input = {
        "*" = {
          xkb_options = "caps:swapescape";
        };
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "40";
        };
      };

      modifier = "Mod4"; # Super key; Cuz I'm a super boy and not an alt boy lol

      fonts = {
        names = [ "IosevkaTerm Nerd Font" ];
        style = "Regular";
      };

      # Keybindings; muscle memory over sanity
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+Return" = "exec footclient";
          "${mod}+t" = "layout tabbed";
          "${mod}+b" = "exec zen";
          "${mod}+d" = "exec rofi -show drun";
          "${mod}+Shift+S" = "exec ~/scripts/maim.sh";
          "${mod}+Shift+D" = "exec ~/scripts/swappy.sh";

          # Media keys: press for dopamine
          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume +5";
          "XF86AudioLowerVolume" = "exec swayosd-client --output-volume -5";
          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "XF86MonBrightnessUp" = "exec swayosd-client --brightness +5";
          "XF86MonBrightnessDown" = "exec swayosd-client --brightness -5";
          "XF86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";

          "${mod}+Shift+n" = "exec playerctl next";
          "${mod}+Shift+p" = "exec playerctl previous";
          "${mod}+q" = "exec playerctl play-pause";
          "${mod}+p" = "exec swaync-client -t"; # toggle notifications panel

          # Window control; because I don't like to scream "MOVE DAMMIT" at my screen
          "${mod}+w" = "kill";
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+s" = "layout stacking";
        };

      defaultWorkspace = "workspace number 1";
      bars = [ ];

      window = {
        border = 2;
        titlebar = false;
      };
    };

    # Extra Sway config for i3-style bar, retro but functional
    extraConfig = ''
      bar {
        font pango:IosevkaTerm Nerd Font 11
        mode dock
        hidden_state hide
        position bottom
        status_command i3status
        tray_output primary
        tray_padding 2
        icon_theme "Adwaita-dark"
        colors {
          background #222222E5 
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

  # Lock screen: swaylock-effects because plain swaylock is ugly
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
