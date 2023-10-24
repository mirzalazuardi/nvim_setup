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
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
})

    map("n", "<leader>fb", telescope.buffers)
    map("n", "<leader>fh", telescope.help_tags)
    map("n", "<leader>fs", telescope.git_status)
    map("n", "<leader>fc", telescope.git_commits)

Find File grep
Find File grep
