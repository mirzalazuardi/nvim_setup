local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy/nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  },
})

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

lspconfig.phpactor.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.ruby_lsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })

lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
