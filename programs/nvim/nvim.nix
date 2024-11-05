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
      nodePackages.typescript-language-server
      docker-compose-language-service
      vscode-langservers-extracted
      lua-language-server
			yaml-language-server
			vim-language-server
      phpactor
      nixd

      xclip
      wl-clipboard
    ];

		plugins = with pkgs.vimPlugins; [
		
		  neodev-nvim
		  cmp_luasnip
      cmp-nvim-lsp
			luasnip
			friendly-snippets
			vim-nix
      vim-jsx-typescript
      vim-wakatime

      nvim-web-devicons

      markdown-preview-nvim
      copilot-cmp

			{
			  plugin = copilot-vim;
			  type = "lua";
        config = "${builtins.readFile ./config/plugin/copilot.lua}";
			}

			{
			  plugin = lualine-nvim;
			  type = "lua";
        config = "require('lualine').setup({icons_enabled = true, theme = 'jellybeans',})";
			}

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
					p.tree-sitter-json
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
      #
      # {
      #   plugin = onedark-nvim;
      #   config = "colorscheme onedark";
      # }

			{
			  plugin = kanagawa-nvim;
				config = "colorscheme kanagawa-dragon";
			}
		];
	};
}
