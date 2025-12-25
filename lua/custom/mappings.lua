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

return M

