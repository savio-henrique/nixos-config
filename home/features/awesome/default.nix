{pkgs, config, lib, ...}:
let 
  awesome = config.awesome;

  # Default rc.lua without custom widgets
  rc = builtins.readFile ./config/rc.lua;
  th = builtins.readFile ./config/theme.lua;
in {
  options = {
    awesome = {
      enable = lib.mkEnableOption "Enable awesome window manager";

      # Widget Configuration
      brightness = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Screen brightness widget";
      };

      battery = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Battery widget";
      };

      volume = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Volume widget";
      };
    };
  };

  config = let
    
    brightness_widget = {
      require = if awesome.brightness then "local brightness_widget = require(\"awesome-wm-widgets.brightness-widget.brightness\")" else "";
      definition = if awesome.brightness then ''
        brightness_widget{
          type = "arc",
          program = "brightnessctl",
          step = 5,
          timeout = 1,
          tooltip = true,
        },
      '' else "";
      binding = if awesome.brightness then ''
        -- Brightness controls
        ,awful.key({}, "XF86MonBrightnessUp", function() brightness_widget:inc(5) end, {description = "increase brightness", group = "widgets"}),
        awful.key({}, "XF86MonBrightnessDown", function() brightness_widget:dec(5) end, {description = "decrease brightness", group = "widgets"})
      '' else "";
      };

    battery_widget = {
      require = if awesome.battery then "local battery_widget = require(\"awesome-wm-widgets.battery-widget.battery\")" else "";
      definition = if awesome.battery then ''
        battery_widget{
          show_current_level = true,
          path_to_icons = gfs.get_configuration_dir() .. "icons/Arc/status/symbolic/"
        },
      '' else "";
    };

    volume_widget = {
      require = if awesome.volume then "local volume_widget = require(\"awesome-wm-widgets.volume-widget.volume\")" else "";
      definition = if awesome.volume then ''
        volume_widget{
          widget_type = "vertical_bar",
          mixer_cmd = "pavucontrol",
          step = 5,
          card = 0,
          device = "default",
          mixctrl = "Master",
        },
      '' else "";
      binding = if awesome.volume then ''
      -- Volume controls
      ,awful.key({}, "XF86AudioRaiseVolume", function() volume_widget:inc(5) end, {description = "increase volume", group = "widgets"}),
      awful.key({}, "XF86AudioLowerVolume", function() volume_widget:dec(5) end, {description = "decrease volume", group = "widgets"}),
      awful.key({}, "XF86AudioMute", function() volume_widget:toggle() end, {description = "mute volume", group = "widgets"})
    '' else "";
    };

  in  lib.mkIf awesome.enable {
    home.file = let
      # Widget File
      widget = let

        # Requires
        requires = brightness_widget.require + battery_widget.require + volume_widget.require;
        # Definitions
        definitions = brightness_widget.definition + battery_widget.definition + volume_widget.definition; 
        # Bindings
        bindings = brightness_widget.binding + volume_widget.binding;
        # Text
        text = rc;
        in builtins.replaceStrings 
          [ "--WIDGET_REQUIRE"  "--WIDGET_DEFINITION" "--WIDGET_BINDING" "--RUNNERCOMMAND"]
          [ "${requires}" "${definitions}" "${bindings}" "${config.visual.runner}" ]
          "${text}";
      # Palette
        palette = config.colorScheme.palette;
        theme = builtins.replaceStrings
          [ "--BACKGROUND" ]
          [ "${config.home-cfg.background}" ]
          "${th}";
      in {

        ".config/awesome/rc.lua" = {
          text = "${widget}";
        };
      
        ".config/awesome/theme" = {
          source = ./config/theme;
          recursive = true;
        };

        ".config/awesome/theme/theme.lua" = {
          target = ".config/awesome/theme/theme.lua";
          text= "${theme}";
        };

        ".config/awesome/awesome-wm-widgets" = {
          source = builtins.fetchGit {
            url = "https://github.com/streetturtle/awesome-wm-widgets.git";
            rev = "68ddbd9812979f1862ebd07f1bf5aa409952e935";
          };
          recursive = true;
        };

        ".config/awesome/icons" = {
          source = builtins.fetchGit {
            url = "https://github.com/horst3180/arc-icon-theme.git";
            rev = "55a575386a412544c3ed2b5617a61f842ee4ec15";
          };
          recursive = true;
        };

        ".config/awesome/theme/colors.lua" = {
          target = ".config/awesome/theme/colors.lua";
          text = ''
            local xresources = require("beautiful.xresources")
            local dpi = xresources.apply_dpi
            local theme = {}

            -- Theme Colors
            theme.bg_normal     = "#${palette.base00}"
            theme.bg_focus      = "#${palette.base03}"
            theme.bg_urgent     = "#${palette.base08}"
            theme.bg_minimize   = "#${palette.base02}"
            theme.bg_systray    = theme.bg_normal
                                      
            theme.fg_normal     = "#${palette.base06}"
            theme.fg_focus      = "#${palette.base07}"
            theme.fg_urgent     = "#${palette.base07}"
            theme.fg_minimize   = "#${palette.base07}"
                                      
            theme.useless_gap   = dpi(4)
            theme.border_width  = dpi(2)
            theme.border_normal = "#${palette.base0F}"
            theme.border_focus  = "#${palette.base09}"
            theme.border_marked = "#${palette.base0E}"
            
            theme.titlebar_bg_color  = theme.border_focus
            theme.titlebar_fg_color  = theme.border_focus

            theme.tasklist_bg_focus  = theme.border_focus
            theme.tasklist_bg_normal = theme.border_normal
            theme.taglist_bg_normal  = theme.border_normal
            theme.taglist_bg_focus   = theme.border_focus
            
            return theme
          '';
        };
    };

    # Add packages
    home.packages = [] ++
      (if awesome.brightness then [ pkgs.brightnessctl ] else []) ++
      (if awesome.battery then [ pkgs.acpi ] else []) ++
      (if awesome.volume then [ pkgs.pavucontrol ] else []);
  };
}
