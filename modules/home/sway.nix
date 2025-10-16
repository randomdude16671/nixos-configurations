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

  programs.sway-easyfocus.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      startup = [
        {
          command = "~/scripts/swayidle.sh";
          always = true;
        }
        { command = "swaybg /etc/nixos/modules/wallpapers/evening.png"; }
        {
          command = "waybar";
          always = false;
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

      modifier = "Mod1";

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
          "${mod}+Return" = "exec kitty";
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
          "${mod}+Shift+j" = "exec sway-easyfocus";
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
    extraConfig = ''
      set $rosewater #f5e0dc
      set $flamingo #f2cdcd
      set $pink #f5c2e7
      set $mauve #cba6f7
      set $red #f38ba8
      set $maroon #eba0ac
      set $peach #fab387
      set $yellow #f9e2af
      set $green #a6e3a1
      set $teal #94e2d5
      set $sky #89dceb
      set $sapphire #74c7ec
      set $blue #89b4fa
      set $lavender #b4befe
      set $text #cdd6f4
      set $subtext1 #bac2de
      set $subtext0 #a6adc8
      set $overlay2 #9399b2
      set $overlay1 #7f849c
      set $overlay0 #6c7086
      set $surface2 #585b70
      set $surface1 #45475a
      set $surface0 #313244
      set $base #1e1e2e
      set $mantle #181825
      set $crust #11111b

      client.focused           $lavender $base $text  $rosewater $lavender
      client.focused_inactive  $overlay0 $base $text  $rosewater $overlay0
      client.unfocused         $overlay0 $base $text  $rosewater $overlay0
      client.urgent            $peach    $base $peach $overlay0  $peach
      client.placeholder       $overlay0 $base $text  $overlay0  $overlay0
      client.background        $base
    '';
  };

  # Lock screen: swaylock-effects because plain swaylock is ugly
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
