{pkgs, config, ... }: 
{ 
  imports = [ 
    # Change the base16  theme for the host
    (import ./home.nix {base16 = "twilight";}) 
    ../common 
    ../common/visual.nix
    ../features/awesome
    ../features/rofi
  ]; 

  awesome.background = "berserk-8.png";
  awesome.runner = "rofi -show drun";

  home.packages = with pkgs; [
    ffmpeg
    davinci-resolve
    prismlauncher
    osu-lazer
  ];
}
