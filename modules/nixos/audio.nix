{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig."10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.dummy-avrcp-player" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.hw-volume" = [
            "a2dp_sink"
            "a2dp_source"
            "hsp_hs"
            "hsp_ag"
          ];
          "bluez5.codecs" = [
            "sbc"
            "aac"
            "sbc_xq"
            "ldac"
            "aptx"
            "aptx_hd"
          ];
          "bluez5.roles" = [
            "hsp_hs"
            "hsp_ag"
            "hfp_hf"
            "hfp_ag"
            "bap_sink"
            "bap_source"
            "a2dp_sink"
            "a2dp_source"
          ];
        };
      };
    };
  };
}
