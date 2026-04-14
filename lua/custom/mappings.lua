local M = {}

M.general = {
  n = {
    ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
    ["<leader>f"] = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>", "Format" },
  },
}

M.lspconfig = {
  n = {
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto References" },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation" },
  },
}

M.markit = {
  n = {
    ["<leader>mt"] = { "<cmd>Markit mark toggle<cr>", "Markit: Toggle mark" },
    ["<leader>mn"] = { "<cmd>Markit mark next<cr>", "Markit: Next mark" },
    ["<leader>mp"] = { "<cmd>Markit mark prev<cr>", "Markit: Prev mark" },
    ["<leader>ml"] = { "<cmd>Markit mark list<cr>", "Markit: List marks" },
    ["<leader>mg"] = { "<cmd>Markit mark goto<cr>", "Markit: Goto mark" },
    ["<leader>mf"] = { "<cmd>Telescope markit marks<cr>", "Telescope marks" },
  }
}

return M

