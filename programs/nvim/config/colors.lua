function ColorMyVim()
	color = color or "base16-twilight"
	vim.cmd.colorscheme(color)
	
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyVim()
