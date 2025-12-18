local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>pf', function()
  builtin.find_files({hidden = true});
end, {desc = "Find Files using Telescope"})
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "Find Git Files using Telescope"})
vim.keymap.set('n', '<leader>ps', function ()
  builtin.grep_string({search = vim.fn.input("Grep > ") });
end, { desc = "Grep for a string using Telescope"})
