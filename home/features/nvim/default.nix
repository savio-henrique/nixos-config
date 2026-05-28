{ lib, pkgs, config , ... }:
let
  nvim = config.nvim;
in {
  options.nvim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Neovim";
    };

    base16 = lib.mkOption {
      type = lib.types.str;
      default = "twilight";
      description = "Base16 color scheme to use";
    };
  };

  config = lib.mkIf nvim.enable {

    # Session Variables
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.sauce-code-pro
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.symbols-only
      pkgs.nerd-fonts.roboto-mono
      pkgs.tree-sitter
    ];

    # Neovim Config
    programs.neovim = {
      enable = true;
      
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withRuby = false;
      withPython3 = false;
      
      # Lua configs
      initLua = ''
        ${builtins.readFile ./config/keymaps.lua}
        ${builtins.readFile ./config/options.lua}
        function ColorMyVim(color)
          color = color or "base16-${nvim.base16}"
          vim.cmd.colorscheme(color)
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
        ColorMyVim()
      '';

      # Plugin configs
      extraPackages = with pkgs; [
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

      plugins = let
        pkg = pkgs.vimPlugins;
        theme = nvim.base16;
        liveserver = pkgs.vimUtils.buildVimPlugin {
          name = "live-server-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "selimacerbas";
            repo = "live-server.nvim";
            rev = "85915d0e7dd926a54b0082aaeafc10a82bfe8288";
            hash = "sha256-Z+BmQ9vSugX0qRpRvT+hniDuegvVDZbF0EsTW+0/R0w=";
          };
        };
        preview = pkgs.vimUtils.buildVimPlugin {
          name = "mermaid-preview-nvim";
          dependencies = [ liveserver ];
          src = pkgs.fetchFromGitHub {
            owner = "selimacerbas";
            repo = "markdown-preview.nvim";
            rev = "545cf3bc6c6425b33a9b25acef54f66e4035ca0f";
            hash = "sha256-SHsbgWoYz9rbL57RS2eAs1kfY4UMzsX8Fh8ZyEVnxkM=";
          };
        };
      in [
        pkg.neodev-nvim
        pkg.cmp_luasnip
        pkg.cmp-nvim-lsp
        pkg.luasnip
        pkg.friendly-snippets
        pkg.vim-nix
        pkg.vim-jsx-typescript

        pkg.nvim-web-devicons

        pkg.copilot-cmp
        pkg.vim-tmux-navigator

        {
          plugin = pkg.nvim-tree-lua;
          type = "lua";
          config = "${builtins.readFile ./config/plugin/nvim-tree.lua}";
        }

        {
          plugin = pkg.nvim-surround;
          type = "lua";
          config = "require('nvim-surround').setup()";
        }

        {
          plugin = pkg.vim-wakatime;
          type = "lua";
          config = ''
            local keyFile = io.open("${config.sops.secrets.wakatime-key.path}", "r")
            local key = keyFile:read("*all")
            local wakatimeFile = io.open("${config.home.homeDirectory}/.wakatime.cfg", "w")
            wakatimeFile:write("[settings]\ndebug = false\nhidefilenames = false\nignore =\n\tCOMMIT_EDITMSG$\n\tPULLREQ_EDITMSG$\n\tMERGE_MSG$\n\tTAG_EDITMSG$\napi_key="..key)
            wakatimeFile:close()
          '';
        }

        {
          plugin = pkg.vim-fugitive;
          type = "lua";
          config = "${builtins.readFile ./config/plugin/fugitive.lua}";
        }

        {
          plugin = pkg.indent-blankline-nvim;
          type = "lua";
          config = "require('ibl').setup()";
        }

        {
          plugin = pkg.undotree;
          type = "lua";
          config = "${builtins.readFile ./config/plugin/undotree.lua}";
        }

        {
          plugin = pkg.copilot-vim;
          type = "lua";
          config = "${builtins.readFile ./config/plugin/copilot.lua}";
        }

        {
          plugin = pkg.lualine-nvim;
          type = "lua";
          config = "require('lualine').setup({icons_enabled = true, theme = 'base16-${theme}',})";
        }

        {
          plugin = pkg.comment-nvim;
          type = "lua";
          config = "require('Comment').setup()";
        }

        {
          plugin = pkg.nvim-lspconfig;
          type = "lua";
          config = "${builtins.readFile ./config/plugin/lsp.lua}";
        }

        {
          plugin = pkg.nvim-cmp;
          type = "lua";
          config = "${builtins.readFile ./config/plugin/cmp.lua}";
        }

        {
          plugin = pkg.telescope-nvim;
          type = "lua";
          config = "${builtins.readFile ./config/plugin/telescope.lua}";
        }

        {
          plugin = pkg.nvim-treesitter.withAllGrammars;
          type = "lua";
        }

        {
          plugin = liveserver;
          type = "lua";
          config = "require('live_server').setup({ default_port = 8080, live_reload = { enabled = true, inject_script = true, debounce = 120, css_inject = true}, directory_listing = { enabled = true, show_hidden = false }})";
        }

        {
          plugin = preview;
          type = "lua";
          config = "require('markdown_preview').setup({ default_theme = \"dark\"})";
        }

        {
          plugin = pkg.base16-nvim;
          type = "lua";
          config = "vim.cmd.colorscheme('base16-${theme}')";
        }
      ];
    };

    sops.secrets.wakatime-key = {
      sopsFile = ../../../hosts/common/secrets.yaml;
    };
  };
}
