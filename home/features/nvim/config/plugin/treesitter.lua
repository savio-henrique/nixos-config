-- require('nvim-treesitter.configs').setup {
--   ensure_installed = {},
--
--   auto_install = false,
--
--   highlight = { enable = true },
--
--   indent = { enable = true },
--
--   additional_vim_regex_highlighting = false,
-- }
-- The new nvim-treesitter (`main` branch) does not start
          -- automatically. This autocmd starts it and auto-installs the
          -- language parser based on the `filetype`.
          vim.api.nvim_create_autocmd({ 'Filetype' }, {
            callback = function(event)
              -- Make sure nvim-treesitter is available
              local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')
              if not ok then return end

              local parsers = require('nvim-treesitter.parsers')

              if not parsers[event.match] or not nvim_treesitter.install then return end

              local ft = vim.bo[event.buf].ft
              local lang = vim.treesitter.language.get_lang(ft)
              nvim_treesitter.install({ lang }):await(function(err)
                if err then
                  vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
                  return
                end

                pcall(vim.treesitter.start, event.buf)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                -- vim.wo.foldmethod = 'expr'
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
              end)
            end,
          })
