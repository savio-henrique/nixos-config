{ pkgs, config, ...}:
{
	#	Alacritty configs
	programs.alacritty.enable = true;
  programs.alacritty.settings = {
		window = {
	 		opacity = 0.8;
	 		title = "Terminal";
	 		dynamic_title = false;
		};
	 	colors = {
			primary = with config.colorScheme.colors; {
	 			foreground = "0x${base06}";
	 			background = "0x${base00}";
	 		};
		};
  };
}
