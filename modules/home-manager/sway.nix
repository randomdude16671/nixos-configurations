{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    slurp
    grim
    swappy
		autotiling-rs 
    i3status
  ];
  services.swayosd.enable = true;
  wayland.windowManager.sway = {
    enable = true;
    config = {
			startup = [
				{
					command = "~/scripts/swayidle.sh"; 
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
        names = ["Iosevka Term Nerd Font"];
        style = "Regular";
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec foot";
          "${modifier}+t" = "layout tabbed";
          "${modifier}+b" = "exec librewolf";
          "${modifier}+d" = "exec rofi -show drun";
          "${modifier}+Shift+S" = "exec ~/scripts/maim.sh";
          "${modifier}+Shift+D" = "exec ~/scripts/swappy.sh";
          "XF86AudioRaiseVolume" = "exec pamixer --increase 5";
          "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
          "${modifier}+w" = "kill";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+s" = "layout stacking";
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
        font pango:Iosevka Term Nerd Font 10
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
}
