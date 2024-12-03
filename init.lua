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
  require'colorizer'.setup()
  require('gitsigns').setup()
  require('configs.gitsigns')
  require("mason").setup()
  require('mason-lspconfig').setup()
  require('lualine').setup()
  require("nvim-tree").setup()
  require('gitblame').setup {
    enabled = true,
  }
end

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
