vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Custom mappings
  vim.keymap.set('n', '<leader>t', api.tree.toggle, opts('Toggle Tree'))
end
require('nvim-tree').setup {
  on_attach = my_on_attach,
  filters = {
    dotfiles = false,
  },
  view = {
    width = 30,
    side = 'left',
  },
}

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Explorer" })
