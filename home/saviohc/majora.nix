{ pkgs, config, ... }: 
{ 
  imports = [ ./home.nix ../common ../common/visual.nix ../features/awesome ]; 

  awesome.brightness = true;
  awesome.volume = true;
  awesome.battery = true;

  home.packages = with pkgs; [
    vesktop
  ];
}
