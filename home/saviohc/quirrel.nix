{ pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual 
  ]; 

  # Change the base16  theme for the host
  home-cfg.base16 = "da-one-sea";

  home-cfg.background = "hollow-knight-2.jpg";
  visual.runner = "rofi -show drun";
  visual.environment = "hyprland";

  home.packages = builtins.attrValues {
    inherit (pkgs) vivaldi;
  };

  home.shellAliases = {
    setmon = "xrandr --output HDMI-1-0 --auto --left-of eDP-1";
  };
}
