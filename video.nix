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
    services.desktopManager.xfce.enable = false;

    services.xserver.windowManager.${cfg.wm}.enable = {
      enable = true;
      extraPackages = with pkgs; [
          dmenu
	  pcmanfm
	  alacritty
        ];
      };
    
    services.xserver.displayManager.defaultSession = "none+${cfg.wm}";

    # Keyboard xserver config
    services.xserver.xkb.layout = "us,br";
    services.xserver.xkb.options = "grp:rctrl_rshift_toggle";

    # Picom
    services.picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      fadeSteps = [ 0.4 0.4 ];

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
	 "100:class_g = 'dmenu'"
      ];
      shadowOffsets = [ (-40) (-20) ];
      
      # Extra configs
      settings = {

	cornerRadius = 10;
	roundBorders = 1;

	focusExclude = [
	  "class_g = 'Cairo-clock'"
	  "class_g = 'Bar'"
	  "class_g = 'slop'"
	  "class_g = 'brave'"
	];

	blur = {
	  method = "dual_kawase";
	  strength = 7;
	  background = true;
	  backgroundFrame = false;
	  backgroundFixed = false;
	};
        vsync = true;
      };

      # Wintype
      wintypes = {
	normal = {
	  fade = false;
	  shadow = false;
	};
	tooltip = {
	  fade = true; 
	  shadow = true;
	  opacity = 0.75;
	  focus = true;
	  fullShadow = false;
	};
	dock = {
	  shadow = false;
	};
	dnd = {
	  shadow = false;
	};
	popup_menu = {
	  opacity = 0.9;
	};
	dropdown_menu = { 
	  opacity = 0.8;
	};
      };
    };
  };
}
