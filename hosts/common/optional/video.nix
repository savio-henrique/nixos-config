{pkgs, config, lib, ...}:
let
  cfg = config.video;
in {
  options.video = {
    dual = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "enable dual monitor setup";
    };
  };

  # Video Configs
  imports = [
    ./picom.nix
    ./nvidia.nix
  ];

  # Dual Monitor Config
  services.xserver.xrandrHeads = [
    lib.mkIf cfg.dual {
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

  # Enable X11 and Window Manager
  services.xserver.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  services.displayManager.defaultSession = "none+awesome";
  services.xserver.videoDrivers = ["nvidia"];

  # Keyboard xserver config
  services.xserver.xkb.layout = "us,br";
  services.xserver.xkb.options = "altwin:menu,altwin:swap_lalt_lwin,grp:rctrl_rshift_toggle,caps:escape";

  environment.systemPackages = with pkgs; [
    arandr
    mons
  ];
  
  # OpenGL Config
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
