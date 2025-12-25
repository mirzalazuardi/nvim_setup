local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    -- Next.js/TS/JS
    null_ls.builtins.formatting.prettierd.with {
      filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "jsonc", "css", "scss" },
    },
    null_ls.builtins.diagnostics.eslint_d.with {
      filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
    -- Python
    null_ls.builtins.formatting.black.with { extra_args = { "--line-length=88" } },
    null_ls.builtins.diagnostics.ruff,
  },
}

