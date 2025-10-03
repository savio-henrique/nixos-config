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
    environment = lib.mkOption {
      default = "awesome";
      type = lib.types.enum [ "awesome" "sway" "hyprland" ];
      description = "enable X11 with AwesomeWM configuration";
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

    # Awesome Config
    picom.enable = cfg.environment == "awesome";

    # X11 Config
    services = lib.mkIf (cfg.environment == "awesome") {
      xserver = {
        enable = true;
        windowManager.awesome.enable = true;
        displayManager.lightdm = {
          enable = true;
          greeter.enable = true;
        };
        displayManager.defaultSession = "none+awesome";
        # Remove XTerm
        excludePackages = [ pkgs.xterm ];
        desktopManager.xterm.enable = false;
        # Keyboard xserver config
        xkb.layout = "us,br";
        xkb.options = "altwin:menu,altwin:swap_lalt_lwin,grp:rctrl_rshift_toggle,caps:escape";
      } // lib.optionalAttrs (cfg.environment == "hyprland") {
        displayManager.sddm.enable = true;
        displayManager.defaultSession = "";
      };

    };

    # Hyprland Config
    programs.hyprland = lib.mkIf (cfg.environment == "hyprland") {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

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
