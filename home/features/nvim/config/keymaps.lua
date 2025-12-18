print("Keymaps Loaded!")
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>v', vim.cmd.vsplit, { desc = "Vertical Split" })
vim.keymap.set('n', '<leader>h', vim.cmd.split, { desc = "Horizontal Split" })
