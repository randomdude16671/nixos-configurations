{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (builtins) concatStringsSep;
  palette = {
    rosewater = "#f5e0dc";
    flamingo = "#f2cdcd";
    pink = "#f5c2e7";
    mauve = "#cba6f7";
    red = "#f38ba8";
    maroon = "#eba0ac";
    peach = "#fab387";
    yellow = "#f9e2af";
    green = "#a6e3a1";
    teal = "#94e2d5";
    sky = "#89dceb";
    sapphire = "#74c7ec";
    blue = "#89b4fa";
    lavender = "#b4befe";
    text = "#cdd6f4";
    subtext1 = "#bac2de";
    subtext0 = "#a6adc8";
    overlay2 = "#9399b2";
    overlay1 = "#7f849c";
    overlay0 = "#6c7086";
    surface2 = "#585b70";
    surface1 = "#45475a";
    surface0 = "#313244";
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
  };
in
{
  home.packages = with pkgs; [
    slurp # select screen regions like a pro
    grim # screenshots, but grim
    satty # annotate like you mean it (updated: swappy->satty (faster, nicer lookin'))
    autotiling-rs # because manual tiling is for people with too much time
    brightnessctl # control the brightness like a masochist
    playerctl # music control for people too focused to move to different workspaces
    swaybg # set background
    hyprpicker # pick colors
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
          command = "${pkgs.foot}/bin/foot --server";
          always = true;
        }
        {
          command = "swaybg -mfill -i /home/ghost/nixos/modules/wallpapers/evening.png";
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
          command = "swayosd-server";
          always = true;
        }
        {
          command = "autotiling-rs";
          always = true;
        }
      ];

      colors = {
        focused = {
          childBorder = "${palette.yellow}";
          background = "${palette.base}";
          text = "${palette.text}";
          indicator = "${palette.rosewater}";
          border = "${palette.yellow}";
        };
        focusedInactive = {
          childBorder = "${palette.overlay0}";
          background = "${palette.base}";
          text = "${palette.text}";
          indicator = "${palette.rosewater}";
          border = "${palette.overlay0}";
        };
        unfocused = {
          childBorder = "${palette.overlay0}";
          background = "${palette.base}";
          text = "${palette.text}";
          indicator = "${palette.rosewater}";
          border = "${palette.overlay0}";
        };
        urgent = {
          childBorder = "${palette.peach}";
          background = "${palette.base}";
          text = "${palette.peach}";
          indicator = "${palette.overlay0}";
          border = "${palette.peach}";
        };
        placeholder = {
          childBorder = "${palette.overlay0}";
          background = "${palette.base}";
          text = "${palette.text}";
          indicator = "${palette.overlay0}";
          border = "${palette.overlay0}";
        };
        background = "${palette.base}";
      };

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
          "${mod}+c" = "exec sh -c 'color=$(hyprpicker) && echo -n color | wl-copy'";

          "${mod}+Return" = "exec footclient";
          "${mod}+t" = "layout tabbed";
          "${mod}+b" = "exec zen";
          "${mod}+d" = "exec fuzzel";
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
