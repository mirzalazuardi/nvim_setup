if vim.g.vscode then
  require('plugins')
else
  require('settings')
  require('plugins')
  require('colorbuddy').colorscheme('gruvbuddy')
  require('configs.telescope')
  require('configs.nvim-cmp')
  require('configs.indent-blankline')
  require("configs.oneterm")
  require("configs.whichkey")
  require("configs.dap")
  require('gitsigns').setup()
  require('configs.gitsigns')
  require("mason").setup()
  require('lualine').setup()
  require("nvim-tree").setup()
  require('gitblame').setup {
    enabled = true,
  }
end
