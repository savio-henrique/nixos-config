{ pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual.nix 
    ../features/awesome
    ../features/rofi
    ../features/steam.nix
  ]; 

  # Change the base16  theme for the host
  home-cfg.base16 = "gotham";

  awesome.brightness = true;
  awesome.volume = true;
  awesome.battery = true;
  awesome.background = "badtzmaru-1.png";
  awesome.runner = "rofi -show drun";
}
