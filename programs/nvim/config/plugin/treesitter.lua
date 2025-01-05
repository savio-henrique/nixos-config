require('nvim-treesitter.configs').setup {
    ensure_installed = {},

    auto_install = false,

    highlight = { enable = true },

    indent = { enable = true },

		additional_vim_regex_highlighting = false,
}
