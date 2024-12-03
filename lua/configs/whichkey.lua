local wk = require("which-key")
-- wk.register({
--   ["<leader>f"] = { name = "+file" },
--   ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Tele Find File" },
--   ["<leader>fg"] = { "<cmd>Telescope live_grep_args<cr>", "Tele Grep file" },
--   ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Tele Buffers" },
--   ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Tele Help tags" },
--   ["<leader>fs"] = { "<cmd>Telescope git_status<cr>", "Tele Git status" },
--   ["<leader>fc"] = { "<cmd>Telescope git_commits<cr>", "Tele Git commits" },
--   ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Tele Open Recent File" },
--   ["<leader>fe"] = { "<cmd>NvimTreeFindFileToggle<cr>", "Nvim tree explorer" },
--   ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
--
--    -- Add LazyGit commands
--   ["<leader>G"] = { name = "+LazyGit" },
--   ["<leader>Gg"] = { "<cmd>LazyGit<cr>", "Open LazyGit" },
--   ["<leader>Gc"] = { "<cmd>LazyGitConfig<cr>", "LazyGit Config" },
--   ["<leader>Gf"] = { "<cmd>LazyGitFilter<cr>", "LazyGit Filter" },
--   ["<leader>Gh"] = { "<cmd>Telescope git_file_history<cr>", "Git File History" },
-- })

wk.add({
  { "<leader>t", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Tree" },
  { "<leader>f", group = "Find file" }, -- group
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "File", mode = "n" },
  { "<leader>fg", "<cmd>Telescope live_grep_args<cr>", desc = "Grep File", mode = "n" },
  { "<leader>ft", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  { "<leader>fh", "<cmd>Telescope git_file_history<cr>", desc = "History File", mode = "n" },
  { "<leader>G", "<cmd>LazyGit<cr>", desc = "Git", mode = "n" },
  { "<leader>n", group = "New" }, -- group
  { "<leader>nn", "<cmd>new<cr>",desc = "New" },
  { "<leader>nv", "<cmd>vnew<cr>",desc = "Vertical" },
  { "<leader>s", "<cmd>Telescope git_status<cr>", desc = "Status(git)" },
  { "<leader>S", group = "Split" }, -- group
  { "<leader>Ss", "<cmd>split<cr>", desc = "Split" },
  { "<leader>Sv", "<cmd>vsplit<cr>", desc = "Split(vertical)" },
  -- { "<leader>fn", desc = "New File" },
  -- { "<leader>f1", hidden = true }, -- hide this keymap
  -- { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  -- { "<leader>b", group = "buffers", expand = function()
  --     return require("which-key.extras").expand.buf()
  --   end
  -- },
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})
