return {
  -- Claude Code: Anthropic CLI integration for AI-assisted coding
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
      { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
      { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
      { "<leader>ct", "<cmd>ClaudeCodeFileTree<cr>", desc = "Claude file tree" },
    },
  },

  -- Codeium: AI completion gratis
  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    config = function()
      require("codeium").setup {}
    end,
  },

  -- gen.nvim: chat/refactor using Ollama (local or remote)
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "llama3",
      host = "http://localhost:11434",
      quit_map = "q",
      retry_map = "<c-r>",
      accept_map = "<c-y>",
    },
    keys = {
      { "<leader>ai", ":Gen<CR>", desc = "AI chat/refactor (Gen.nvim)" },
    },
  },

  -- Aider CLI helper
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
