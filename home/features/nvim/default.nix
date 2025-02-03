{base16 }: { lib, pkgs, config , ... }:
{

  # Session Variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    (pkgs.nerdfonts.override { fonts= [ "SourceCodePro" "FiraCode" "JetBrainsMono" ];})
  ];

  # Neovim Config
  programs.neovim = {
    enable = true;
    
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    # Lua configs
    extraLuaConfig = ''
      ${builtins.readFile ./config/keymaps.lua}
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/colors.lua}
    '';

    # Plugin configs
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
        plugin = vim-fugitive;
        type = "lua";
        config = "${builtins.readFile ./config/plugin/fugitive.lua}";
      }

      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = "require('ibl').setup()";
      }

      {
        plugin = undotree;
        type = "lua";
        config = "${builtins.readFile ./config/plugin/undotree.lua}";
      }

      {
        plugin = copilot-vim;
        type = "lua";
        config = "${builtins.readFile ./config/plugin/copilot.lua}";
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = "require('lualine').setup({icons_enabled = true, theme = 'base16-twilight',})";
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

      {
        plugin = base16-nvim;
        config = "colorscheme base16-${base16}";
      }

      # {
      #   plugin = kanagawa-nvim;
      # 	config = "colorscheme kanagawa-dragon";
      # }
	];
  };
}
