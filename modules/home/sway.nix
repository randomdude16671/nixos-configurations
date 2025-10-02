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
    satty # annotate like you mean it (updated: swappy->satty (faster, nicer lookin'))
    autotiling-rs # because manual tiling is for people with too much time
    brightnessctl # control the brightness like a masochist
    playerctl # music control for people too focused to move to different workspaces
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
          command = "waybar";
          always = false;
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

      gaps = {
        outer = 6;
        inner = 6;
        smartGaps = false;
      };
      window = {
        border = 2;
        titlebar = false;
      };
      floating = {
        border = 2;
        titlebar = false;
      };
    };
  };

  # Lock screen: swaylock-effects because plain swaylock is ugly
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
