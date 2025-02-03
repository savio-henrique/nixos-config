{ pkgs, config, ... }: 
{ 
  imports = [ ./home.nix ../common ../common/visual.nix ../features/awesome ]; 

  awesome.brightness = true;
  awesome.volume = true;
  awesome.battery = true;
  awesome.background = "badtz_maru_wide_1.png";

  home.packages = with pkgs; [
    vesktop
  ];
}
