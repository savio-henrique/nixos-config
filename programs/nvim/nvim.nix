{ lib, pkgs, config , ... }:
{
	programs.neovim = {
 		enable = true; 
			
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;

    extraLuaConfig = ''
			${builtins.readFile ./config/keymaps.lua}
			${builtins.readFile ./config/options.lua}
    '';

		extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];

		plugins = with pkgs.vimPlugins; [
		
		  neodev-nvim
		  cmp_luasnip
			luasnip
			lualine-nvim
			friendly-snippets
			vim-nix

			{
			  plugin = comment-nvim;
			  type = "lua";
        config = "require('Comment').setup()";
			}

		  {
		  	plugin = nvim-lspconfig;
				type = "lua";
				config = "${builtins.readFile ./config/plugin/lsp.lua}";
			}

		  {
		  	plugin = nvim-cmp;
				type = "lua";
				config = "${builtins.readFile ./config/plugin/cmp.lua}";
			}

			{
		  	plugin = telescope-nvim;
				type = "lua";
				config = "${builtins.readFile ./config/plugin/telescope.lua}";
			}

		  {
		  	plugin = (nvim-treesitter.withPlugins (p : [
					p.tree-sitter-nix
					p.tree-sitter-vim
					p.tree-sitter-bash
					p.tree-sitter-lua
					p.tree-sitter-python
					p.tree-sitter-jsonv
					p.tree-sitter-css
					p.tree-sitter-yaml
					p.tree-sitter-html
					p.tree-sitter-markdown
					p.tree-sitter-tsx
					p.tree-sitter-typescript
					p.tree-sitter-javascript
					p.tree-sitter-dockerfile
					p.tree-sitter-php
				]));
				type = "lua";
				config = "${builtins.readFile ./config/plugin/treesitter.lua}";
			}

			{
			  plugin = kanagawa-nvim;
				config = "colorscheme kanagawa-dragon";
			}
		];
	};
}
