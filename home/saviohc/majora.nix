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
  home-cfg.base16 = "gotham";
  home-cfg.background = "badtzmaru-1.png";
  visual.runner = "rofi -show drun";
  visual.environment = "awesome";

  awesome.brightness = true;
  awesome.volume = true;
  awesome.battery = true;

  home.packages = builtins.attrValues {
    inherit (pkgs) vivaldi;
  };
}
