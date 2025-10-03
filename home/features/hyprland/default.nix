{pkgs, config, lib, ...}:
let
  cfg = config.hypr; 
in {
  imports = [
    ./hyprpaper.nix
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
        "$mod" = "SUPER";
        "$terminal" = "${config.programs.alacritty.package}/bin/alacritty";
        "$fileManager" = "pcmanfm";
        "$browser" = "brave";
        monitor = ",preferred,auto,auto";
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bind = [
          "$mod RETURN, exec, $terminal"
          "$mod SHIFT, Q, exec, logout"
          "$mod SHIFT, C, killactive"
          "$mod SHIFT, F, exec, $browser"
          "$mod, R, exec, ${config.visual.runner}"
          "$mod, F, exec, $fileManager"
          "$mod, E, exec, code"
          "$mod, mouse_up, workspace, e-1"
          "$mod, mouse_down, workspace, e+1"
        ]++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9));
        exec-once = [
          "waybar"
          "hyprpaper"
        ];
      };
    };
  };
}
