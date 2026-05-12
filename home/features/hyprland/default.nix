{pkgs, config, lib, ...}:
let
  cfg = config.hypr; 
in {
  imports = [
    ./hyprpaper.nix
    ./binds.nix
    ./hyprlock.nix
  ];
  options.hypr = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland window manager and related configurations.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.waybar.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "ALT_L";
        "$terminal" = "alacritty";
        "$fileManager" = "pcmanfm";
        "$browser" = "brave";

        input = {
          "kb_layout" = "us,br";
          "kb_variant" = ",thinkpad";
          "kb_options" = "grp:menu_toggle,caps:escape";
        };

        # Configure monitors
        monitor = map (m: "${m.name},${
        if m.enabled
        then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},${toString m.scale}"
        else "disable"
      }") (config.monitors);

        # Configure Binds
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bind = [
          "$mod, RETURN, exec, $terminal"
          "$mod SHIFT, Q, exec, logout"
          "$mod SHIFT, C, killactive"
          "$mod CONTROL, F, exec, $browser"
          "$mod, R, exec, ${config.visual.runner}"
          "$mod, F, fullscreen"
          "$mod, mouse_up, workspace, e-1"
          "$mod, mouse_down, workspace, e+1"
        ];
        exec-once = [
          "waybar"
          "hyprpaper"
        ];
      };
      plugins = [
        pkgs.hyprlandPlugins.hyprsplit
      ];
    };
  };
}
