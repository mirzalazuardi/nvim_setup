require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local opts = { noremap = true, silent = true }

-- 🧠 AI shortcuts
map("n", "<leader>ai", ":Gen<CR>", opts) -- Chat/refactor AI
map("n", "<leader>ac", ":Codeium Toggle<CR>", opts) -- Toggle Codeium
map("n", "<leader>at", ":!aider .<CR>", opts) -- Jalankan Aider CLI (opsional)

-- 🧪 Test shortcuts
map("n", "<leader>tt", function()
  require("neotest").run.run()
end, opts)
map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, opts)
map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, opts)

-- 🧹 Formatter
map("n", "<leader>ff", vim.lsp.buf.format, opts)
