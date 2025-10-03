{inputs,config, lib, outputs, pkgs, ...}: 
let 
  visual = config.visual;
in {
  imports = [
    ./gtk.nix
    ../../features/awesome
    ../../features/rofi
    ../../features/hyprland
    ../../features/alacritty.nix
    ../../features/vesktop
    ../../features/obs
  ];

  options.visual = {
    environment = lib.mkOption {
      type = lib.types.enum [ "hyprland" "awesome" ];
      default = "awesome";
      description = "Choose your window manager environment.";
    };
    backgroundPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.config/wallpapers";
      description = "Background image path.";
    };
    runner = lib.mkOption {
      type = lib.types.str;
      default = "rofi -show drun";
      description = "Application launcher command.";
    };
  };

  config = {
    awesome = lib.mkIf (visual.environment == "awesome") {
      enable = true;
    };
    hypr = lib.mkIf (visual.environment == "hyprland") {
      enable = true;
    };


    home.packages = with pkgs; [
      # Tools
      pavucontrol
      pcmanfm
      dmenu
      libreoffice
      corefonts
      handlr-regex

      # Applications
      spotify
      brave
      firefox
      flameshot
      ffmpeg
      vlc
      gimp
      qimgv
    ];
  };
}
