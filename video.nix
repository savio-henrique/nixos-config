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
  };
}
