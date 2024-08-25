local wk = require("which-key")
wk.register({
  ["<leader>f"] = { name = "+file" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Tele Find File" },
  ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Tele Grep file" },
  ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Tele Buffers" },
  ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Tele Help tags" },
  ["<leader>fs"] = { "<cmd>Telescope git_status<cr>", "Tele Git status" },
  ["<leader>fc"] = { "<cmd>Telescope git_commits<cr>", "Tele Git commits" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Tele Open Recent File" },
  ["<leader>fe"] = { "<cmd>NvimTreeFindFileToggle<cr>", "Nvim tree explorer" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },

   -- Add LazyGit commands
  ["<leader>g"] = { name = "+LazyGit" },
  ["<leader>gg"] = { "<cmd>LazyGit<cr>", "Open LazyGit" },
  ["<leader>gc"] = { "<cmd>LazyGitConfig<cr>", "LazyGit Config" },
  ["<leader>gf"] = { "<cmd>LazyGitFilter<cr>", "LazyGit Filter" },
  ["<leader>gh"] = { "<cmd>Telescope git_file_history<cr>", "Git File History" },
})
