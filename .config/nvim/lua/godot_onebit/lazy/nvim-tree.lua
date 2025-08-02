-- in your plugins.lua or wherever you define plugins
return{
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = function()
    require("nvim-tree").setup()
    vim.keymap.set('n', '<leader>n', vim.cmd.NvimTreeToggle)
  end
}

