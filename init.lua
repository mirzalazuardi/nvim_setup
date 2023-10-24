if vim.g.vscode then
  require('plugins')
else
  require('settings')
  require('plugins')
  require('colorbuddy').colorscheme('gruvbuddy')
  require('configs.telescope')
  require('configs.nvim-cmp')
  require('configs.indent-blankline')
  require('gitsigns').setup()
  require('configs.gitsigns')
  require("mason").setup()
  require('lualine').setup()
  require("nvim-tree").setup()
  require('maps')
  require('gitblame').setup {
    enabled = true,
  }
end
