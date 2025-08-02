require("godot_onebit.remap")
require("godot_onebit.set")
require("godot_onebit.lazy_init")

local augroup = vim.api.nvim_create_augroup
local OneBitGroup = augroup('OneBit', {})
local autocmd = vim.api.nvim_create_autocmd

function R(name)
    require('plenary.reload').reload_module(name)
end

autocmd('LspAttach', {
	group = OneBitGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.type_definition() end, opts)
		vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
		vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
		vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
		vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set('n', '<C-h>', function() vim.lsp.buf.hover() end, opts)

		-- Diagnostic keymaps
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
		vim.keymap.set('n', '<leader>m', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
		vim.keymap.set('n', '<leader>ml', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
	end
})
