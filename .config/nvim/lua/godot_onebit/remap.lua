vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

--Yank to clipboard
vim.keymap.set('n','<leader>y','\"+y')
vim.keymap.set('v','<leader>y','\"+y')
vim.keymap.set('n','<leader>yap','\"+yap')
vim.keymap.set('n','<leader>yap','\"+yap')

vim.keymap.set("n", "<leader>td", vim.cmd.TodoTelescope, { desc = "List TODOs" })
vim.keymap.set("n","<C-g>",vim.cmd.LazyGit)
