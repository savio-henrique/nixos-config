{pkgs, config, lib, ...}:
let
  cfg = config.video;
in {
  imports = [
    ./picom.nix
    ./nvidia.nix
  ];

  options.video = {
    enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "enable video configuration";
    };
    dual = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "enable dual monitor configuration";
    };
  };

  # Video Configs
  config = lib.mkIf cfg.enable {
    # Dual Monitor Config
    # services.xserver.xrandrHeads = lib.optionals (cfg.dual == true) [
    #   {
    #     output = "DP-5";
    #     monitorConfig = ''
    #       Option "PreferredMode" "1920x1080"
    #     '';
    #   }
    #   {
    #     output = "HDMI-0";
    #     primary = true;
    #     monitorConfig = ''
    #         Option "PreferredMode" "2560x1080"
    #     '';
    #   }
    # ];

    # Enable X11 and Window Manager
    services.xserver.enable = true;
    services.xserver.windowManager.awesome.enable = true;
    services.xserver.displayManager.startx.enable = true;
    services.xserver.displayManager.lightdm = {
      enable = true;
      greeter.enable = true;
    };
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
  };
}
