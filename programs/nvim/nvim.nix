{ lib, pkgs, config , ... }:
{
	programs.neovim = {
 		enable = true; 
			
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;

    extraLuaConfig = ''
			${builtins.readFile ./config/options.lua}
			${builtins.readFile ./config/keymaps.lua}
    '';

		plugins = with pkgs.vimPlugins; [
			{
			  plugin = comment-nvim;
			  type = "lua";
        config = "require('Comment').setup()";
			}

		  {
		  	plugin = nvim-lspconfig;
				type = "lua";
				config = "${builtins.readfile ./config/plugin/lsp.lua}";
			}

		  {
		  	plugin = nvim-telescope;
				type = "lua";
				config = "${builtins.readfile ./config/plugin/lsp.lua}";
			}

			{
			  plugin = kanagawa-nvim;
				config = "colorscheme kanagawa-dragon";
			}

      #{
			  #plugin = vim-nix;
				#type = "";
				#config = "";
			#}
		];
	};
}
