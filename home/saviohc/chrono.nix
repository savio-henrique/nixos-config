{pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual.nix
    ../features/awesome
    ../features/rofi
  ]; 

  # Change the base16  theme for the host
  home-cfg.base16 = "ayu-dark";

  awesome.background = "berserk-1.png";
  awesome.runner = "rofi -show drun";

  home.packages = with pkgs; [
    ffmpeg
    steam
    davinci-resolve
    prismlauncher
    calibre
    postman
    jetbrains.phpstorm
    dbeaver-bin
    vivaldi
  ];
}
