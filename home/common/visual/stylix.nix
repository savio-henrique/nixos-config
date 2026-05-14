{inputs,config, lib, outputs, pkgs, ...}: 
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.colorscheme}.yaml";
    image= ./../.. + "/${config.home.username}" + "/wallpapers/${config.wallpaper}";
    targets = {
	alacritty.enable = false;
	hyprlock.enable = false;
    hyprland.enable = false;
	neovim.enable = false;
	gtk.enable = true;
    rofi.enable = false;
    tmux.enable = false;
    vscode.enable = false;
    };
  };
}
