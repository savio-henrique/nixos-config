{ lib, pkgs, config , ... }:
{
	programs.neovim = {
 		enable = true; 
			
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;

    extraLuaConfig = ''
			${builtins.readFile ./programs/nvim/config/options.lua}
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
				config = "${builtins.readFile ./programs/nvim/config/plugin/lsp.lua}";
			}

			{
			  plugin = kanagawa-nvim;
				config = "colorscheme kanagawa-wave";
			}

      #{
			  #plugin = vim-nix;
				#type = "";
				#config = "";
			#}
		];
	};
}
