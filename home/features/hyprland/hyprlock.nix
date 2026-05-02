{config, lib, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      animations = {
        enabled = true;
        bezier = [
          "easeout,0.5, 1, 0.9, 1"
          "easeoutback,0.34,1.22,0.65,1"
        ];
        animation = [
          "fade, 1, 3, easeout"
          "inputField, 1, 1, easeoutback"
        ];
      };
      background = {
        path = "screenshot";
        blur_passes = 4;
        brightness = 0.8;
      };
      input-field = lib.forEach config.monitors (monitor: {
        monitor = monitor.name;
        size = "800, 90";
        dots_size = toString (0.25 * monitor.scale);
        placeholder_text = "";
        font_color = "rgb(${config.colorScheme.palette.base06})";
        position = "0, -20%";
        # $FAIL is moves to another label
        fail_text = "";
        # Hide outline and filling
        outline_thickness = 0;
        inner_color = "rgba(00000000)";
        check_color = "rgba(00000000)";
        fail_color = "rgba(00000000)";
      });
      label = lib.flatten (lib.forEach config.monitors (monitor: [
        {
          monitor = monitor.name;
          text = "$TIME";
          color = "rgb(${config.colorScheme.palette.base06})";
          font_size = toString (builtins.floor (140 * monitor.scale));
          position = "0 0";
        }
        {
          monitor = monitor.name;
          text = "$FAIL";
          color = "rgb(${config.colorScheme.palette.base06})";
          font_size = toString (builtins.floor (18 * monitor.scale));
          position = "0, -40%";
        }
      ]));
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = let
        hyprlock = lib.getExe config.programs.hyprlock.package;
      in [
        "$mod,backspace,exec,${hyprlock}"
        "$mod,XF86Calculator,exec,${hyprlock}"
      ];
    };
  };
}
