{ lib, pkgs, config , ... }:
{
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeDelta = 4;
    fadeSteps = [ 0.4 0.4 ];

    # Opacity
    activeOpacity = 1;
    inactiveOpacity = 0.95;
    menuOpacity= 0.95;
    opacityRules = [
      "100:class_g = 'Bar'"
      "100:class_g = 'slop'"
      "100:class_g = 'alacritty'"
      "100:class_g = 'vesktop'"
      "100:class_g = 'obs'"
      "100:class_g = 'brave'"
      "100:class_g = 'rofi'"
    ];


    # Shadow
    # shadow = true;
    # shadowOpacity = 0.55;
    # shadowExclude = [
    #   "name = 'Notification'"
    #   "class_g = 'Conky'"
    #   "class_g ?= 'Notify-osd'"
    #   "class_g = 'Cairo-clock'"
    #   "class_g = 'slop'"
    #   "class_g = 'Polybar'"
    #   "class_g = 'dmenu'"
    # ];
    # shadowOffsets = [ (-40) (-20) ];

    # Extra configs
    settings = {
      corner-radius = 10;
      round-borders = 1;
      rounded-corners-exclude = [
        "class_g = 'awesome'"
      ];

      focus-exclude = [
        "class_g = 'Cairo-clock'"
        "class_g = 'Bar'"
        "class_g = 'slop'"
      ];

      blur = {
        method = "dual_kawase";
        strength = 7;
        background = true;
        background-frame = false;
        background-fixed = false;
      };

      vsync = true;
    };
  };
}
