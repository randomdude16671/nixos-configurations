{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
    swayosd
  ];

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "bottom";
      layer = "overlay";
      control-center-layer = "top";
      notification-2fa-action = true;
      layer-shell = true;
      hide-on-clear = false;
      hide-on-action = true;
      widgets = [
        "title"
        "notifications"
        "mpris"
        "volume"
        "backlight"
        "dnd"
      ];
      widget-config = {
        "title" = {
          text = "Notifs bro";
          clear-all-button = true;
          button-text = "  Clear ALL!";
        };
        "dnd" = {
          text = "Ghost mode?";
        };
        "mpris" = {
          image-size = 96;
        };
        "volume" = {
          label = "󰴸 ";
        };
        backlight = {
          label = " ";
        };
      };
    };
  };
}
