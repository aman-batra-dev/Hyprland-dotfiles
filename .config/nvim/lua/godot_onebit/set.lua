vim.opt.guicursor = ''
vim.opt.mouse = 'a' --Mouse Support

vim.opt.number = true
vim.opt.showmode = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.updatetime = 150
vim.opt.timeoutlen = 1000
