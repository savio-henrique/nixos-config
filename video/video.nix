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
    services.xserver.videoDrivers = ["nvidia"];

    # Keyboard xserver config
    services.xserver.xkb.layout = "us,br";
    services.xserver.xkb.options = "altwin:menu,altwin:swap_lalt_lwin,grp:rctrl_rshift_toggle,caps:escape";

		# Dual Monitor Setup

		services.xserver.xrandrHeads = [
			{
				output = "DP-5";
				monitorConfig = ''
					Option "PreferredMode" "1920x1080"
				'';
			}
			{
        output = "HDMI-0";
        primary = true;
				monitorConfig = ''
					Option "PreferredMode" "2560x1080"
				'';
			}

    ];

    environment.systemPackages = with pkgs; [
      arandr
      mons
    ];

    # OpenGL Config
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Nvidia
    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
