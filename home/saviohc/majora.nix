{ pkgs, config, ... }: 
{ 
  imports = [ ./home.nix ../common ../common/visual.nix ]; 

  home.packages = with pkgs; [
    acpi
    brightnessctl
    alsa-utils
    vesktop
  ];
}
