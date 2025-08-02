return {
	"catppuccin/nvim", 
	name = "catppuccin", 
	config = function()
		require("catppuccin").setup({})
		vim.o.termguicolors = true
		vim.cmd('colorscheme catppuccin')
	end
}
