{ lib, pkgs, config , ... }:

let
  cfg = config.video;
in
{
  options.video = {
    enable = lib.mkEnableOption "enable video configuration";
    
    wm = lib.mkOption {
      type = lib.types.str;
      default = "awesome";
      description = ''
	window manager
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable X11 and Window Manager
    services.xserver.enable = true;
    services.xserver.desktopManager.xfce.enable = false;
    services.xserver.windowManager.${cfg.wm}.enable = true;
    services.displayManager.defaultSession = "none+${cfg.wm}";

    # Keyboard xserver config
    services.xserver.xkb.layout = "us,br";
    services.xserver.xkb.options = "altwin:menu,altwin:swap_lalt_lwin,grp:rctrl_rshift_toggle";

    # Picom
    services.picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      fadeSteps = [ (0.4) (0.4) ];

      # Opacity
      activeOpacity = 0.95;
      inactiveOpacity = 0.5;
      menuOpacity= 0.8;
      opacityRules = [
	"80:class_g = 'Bar'"
	"100:class_g = 'slop'"
	"100:class_g = 'XTerm'"
	"95:class_g = 'alacritty'"
	"90:class_g = 'discord'"
	"90:class_g = 'obs'"
	"90:class_g = 'brave'"
	"100:class_g = 'dmenu'"
      ];


      # Shadow
      shadow = true;
      shadowOpacity = 0.55;
      shadowExclude = [
	"name = 'Notification'"
	"class_g = 'Conky'"
  	"class_g ?= 'Notify-osd'"
  	"class_g = 'Cairo-clock'"
  	"class_g = 'slop'"
  	"class_g = 'Polybar'"
	"class_g = 'dmenu'"
      ];
      shadowOffsets = [ (-40) (-20) ];
      
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
	  "class_g = 'brave'"
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
  };
}
