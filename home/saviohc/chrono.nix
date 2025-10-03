{pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual
  ]; 

  # Change the base16  theme for the host
  home-cfg.base16 = "ayu-dark";
  home-cfg.background = "berserk-1.png";

  visual.environment = "awesome";

  home.packages = with pkgs; [
    davinci-resolve
    prismlauncher
    calibre
    jetbrains.phpstorm
    dbeaver-bin
    vivaldi
    element-desktop
    zotero
    bruno
    audacity
  ];

  # Test Later
  # home.packages = builtins.attrValues { inherit (pkgs)
  #   davinci-resolve
  #   prismlauncher
  #   calibre
  #   dbeaver-bin
  #   vivaldi
  #   element-desktop
  #   zotero
  #   bruno
  #   audacity;
  #   inherit (pkgs.jetbrains) phpstorm;
  # };
}
