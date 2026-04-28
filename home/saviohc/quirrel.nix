{ pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual 
    ../features/awesome
    ../features/rofi
    ../features/steam.nix
  ]; 

  # Change the base16  theme for the host
  home-cfg.base16 = "da-one-sea";
  # Theme Suggestions
  # atelier-sulphurpool
  # ayu-dark
  # ayu-mirage
  # blueish
  # da-one-sea
  # da-one-ocean
  # eldritch

  home-cfg.background = "hollow-knight-2.jpg";
  visual.runner = "rofi -show drun";
  visual.environment = "awesome";

  awesome.brightness = true;
  awesome.volume = true;
  awesome.battery = true;

  home.packages = builtins.attrValues {
    inherit (pkgs) vivaldi;
  };

  home.shellAliases = {
    setmon = "xrandr --output HDMI-1-0 --auto --left-of eDP-1";
  };
}
