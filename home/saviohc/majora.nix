{ pkgs, config, ... }: 
{ 
  imports = [ 
    # Change the base16  theme for the host
    (import ./home.nix {base16 = "gotham";})
    ../common 
    ../common/visual.nix 
    ../features/awesome
    ../features/rofi
  ]; 

  awesome.brightness = true;
  awesome.volume = true;
  awesome.battery = true;
  awesome.background = "badtzmaru-1.png";
  awesome.runner = "rofi -show drun";
}
