vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Add mise bin directories to PATH for formatters/linters
-- Works on both macOS and Linux
local function get_mise_bin_path(tool)
  local handle = io.popen("mise where " .. tool .. " 2>/dev/null")
  if handle then
    local path = handle:read("*a"):gsub("%s+", "")
    handle:close()
    if path ~= "" then
      return path .. "/bin"
    end
  end
  return nil
end

-- Build PATH with mise-managed tools (graceful fallback to standard paths)
local python_bin = get_mise_bin_path("python") or "/usr/bin"
local ruby_bin = get_mise_bin_path("ruby") or "/usr/bin"
local node_bin = get_mise_bin_path("node") or "/usr/local/bin"

vim.env.PATH = python_bin .. ":" .. ruby_bin .. ":" .. node_bin .. ":" .. vim.env.PATH

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- Patch NvChad's LSP defaults for Neovim 0.10 compatibility (no vim.lsp.config)
local ok_nv, nvchad_lsp = pcall(require, "nvchad.configs.lspconfig")
if ok_nv and nvchad_lsp.defaults then
  nvchad_lsp.defaults = function()
    pcall(dofile, vim.g.base46_cache .. "lsp")
    local ok_diag, diag = pcall(require, "nvchad.lsp")
    if ok_diag then
      pcall(diag.diagnostic_config)
    end
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        nvchad_lsp.on_attach(_, args.buf)
      end,
    })
  end
end

local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>tI", "<cmd>lua require('rspec').run_current_file()<cr>", opts)
vim.keymap.set("n", "<leader>ti", "<cmd>lua require('rspec').run_current_example()<cr>", opts)
vim.keymap.set("n", "<leader>t.", "<cmd>lua require('rspec').repeat_last_run()<cr>", opts)
vim.keymap.set("n", "<leader>td", "<cmd>lua require('rspec').debug()<cr>", opts)
vim.keymap.set("n", "<leader>tS", "<cmd>lua require('rspec').run_suite()<cr>", opts)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Dynamically set host programs with graceful fallbacks for Linux/macOS
local function set_host_program(var_name, tool)
  local mise_path = io.popen("mise where " .. tool .. " 2>/dev/null")
  if mise_path then
    local path = mise_path:read("*a"):gsub("%s+", "")
    mise_path:close()
    if path ~= "" then
      vim.g[var_name] = path .. "/bin/" .. tool
      return
    end
  end
  -- Fallback to standard Linux paths
  local std路径 = {
    ruby = "/usr/bin/ruby",
    python = "/usr/bin/python3",
    node = "/usr/local/bin/node",
  }
  vim.g[var_name] = std路径[tool] or ""
end

set_host_program("ruby_host_prog", "ruby")
set_host_program("python3_host_prog", "python")
set_host_program("node_host_prog", "node")

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff_standard" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    ruby = { "rubocop" },
    php = { "phpcbf", "php" },
  },
})

-- DISABLED: Format-on-save (uncomment to re-enable)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     -- Wrap in pcall to prevent errors from uninitialized LSP clients
--     local ok, err = pcall(function()
--       require("conform").format({ bufnr = args.buf })
--     end)
--     if not ok then
--       vim.notify("Format error (will retry): " .. tostring(err), vim.log.levels.WARN)
--     end
--   end,
-- })



vim.opt.listchars = { space = " " }  -- or remove space key entirely


-- vim.opt.listchars = {
--   tab = "→ ",
--   trail = "·",    -- only trailing spaces show as dots
--   extends = "›",
--   precedes = "‹",
--   nbsp = "␣",
--   -- no `space` key = regular spaces are invisible
-- }
