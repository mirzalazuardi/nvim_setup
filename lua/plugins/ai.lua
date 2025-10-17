return {
  -- ✅ Codeium: AI completion gratis
  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    config = function()
      require("codeium").setup {}
    end,
  },

  -- ✅ gen.nvim: chat/refactor pakai Ollama lokal
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "llama3",
      host = "http://localhost:11434", -- pastikan Ollama sudah jalan
      quit_map = "q",
      retry_map = "<c-r>",
      accept_map = "<c-y>",
    },
    keys = {
      { "<leader>ai", ":Gen<CR>", desc = "AI chat/refactor (Gen.nvim)" },
    },
  },

  -- ✅ Aider CLI helper (opsional)
  {
    "axkirillov/easypick.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      local easypick = require "easypick"
      easypick.setup {
        pickers = {
          {
            name = "aider_diff",
            command = "git diff --name-only",
            previewer = easypick.previewers.branch_diff(),
          },
        },
      }
    end,
  },
}
