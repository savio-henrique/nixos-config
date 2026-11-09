{pkgs, config, lib, ...}:
let
  cfg = config.hypr; 
in {
  imports = [
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
    services.mako.enable = true;

    home.packages = [
      pkgs.grim
      pkgs.swappy
      pkgs.slurp
      pkgs.wl-clipboard
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      package= null;
      portalPackage = null;
      systemd.enable = false;
      settings = let
        screenshot = "grim -g \\\"$(slurp)\\\" - | wl-copy";
        in {
        mod = {
          _var = "ALT_L";
        };
        terminal = {
          _var = "alacritty";
        };
        fileManager = {
          _var = "pcmanfm";
        };
        browser = {
          _var = "zen";
        };

        config = {
          input = {
          "kb_layout" = "us,br";
          "kb_variant" = ",thinkpad";
          "kb_options" = "grp:menu_toggle,caps:escape";
          };
        };

        # Configure monitors
        monitor = map (m: if m.enabled then {
          _args = [
            (lib.generators.mkLuaInline "{ output = \"${m.name}\", mode = \"preferred\", position = \"${m.position}\", scale = ${toString m.scale} }")
          ];
        } else {}) config.monitors;

        # Configure Binds
        bind = [
          # Open Terminal
          {
            _args = [
              (lib.generators.mkLuaInline "mod .. \" + RETURN\"")
              (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
            ];
          }
          # Open Browser
          {
            _args = [
              (lib.generators.mkLuaInline "mod .. \" + CONTROL + F\"")
              (lib.generators.mkLuaInline "hl.dsp.exec_cmd(browser)")
            ];
          }
          # Open Runner
          {
            _args = [
              (lib.generators.mkLuaInline "mod .. \" + R\"")
              (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${config.visual.runner}\")")
            ];
          }
          # Take Screenshot
          {
            _args = [
              (lib.generators.mkLuaInline "mod .. \" + P\"")
              (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${screenshot}\")")
            ];
          }
        ];
        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"waybar\")\n  hl.exec_cmd(\"hyprpaper\")\n  hl.exec_cmd(\"mako\")\nend")
          ];
        };
      };
    };
  };
}
