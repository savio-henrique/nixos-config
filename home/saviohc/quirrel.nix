{ pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual 
  ]; 

  # Change the base16  theme for the host
  colorscheme = "da-one-sea";

  visual.runner = "rofi -show drun";
  visual.environment = "hyprland";

  home.packages = builtins.attrValues {
    inherit (pkgs) vivaldi grayjay;
  };

  #  Alias for monitor on xrandr
  # home.shellAliases = {
  #   setmon = "xrandr --output HDMI-1-0 --auto --left-of eDP-1";
  # };

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = 1;
      primary = true;
      position = "1920x0";
      refreshRate = 120;
      scale = 1.0;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      workspace = 2;
      primary = false;
      position = "0x0";
      refreshRate = 60;
      scale = 1.0;
    }
  ];

  wallpaper = "${config.home.homeDirectory}/.config/wallpapers/hollow-knight-2.jpg";
}
