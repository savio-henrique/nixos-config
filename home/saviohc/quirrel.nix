{ pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual 
  ]; 

  # Change the base16  theme for the host
  home-cfg.base16 = "da-one-sea";

  visual.runner = "rofi -show drun";
  visual.environment = "hyprland";

  home.packages = builtins.attrValues {
    inherit (pkgs) vivaldi;
  };

  home.shellAliases = {
    setmon = "xrandr --output HDMI-1-0 --auto --left-of eDP-1";
  };

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = 1;
      primary = true;
      refreshRate = 120;
      scale = 1.0;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      workspace = 2;
      primary = false;
      refreshRate = 60;
      scale = 1.0;
    }
  ];

  wallpaper = "${config.home.homeDirectory}/.config/wallpapers/hollow-knight-2.jpg";
}
