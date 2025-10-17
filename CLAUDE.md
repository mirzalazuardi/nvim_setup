# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **NvChad v2.5-based Neovim configuration** with lazy loading via `lazy.nvim`. NvChad is used as a foundational plugin (not a fork), and this repo extends it with custom plugins and overrides.

### Configuration Structure

- **Entry point**: `init.lua` - Bootstraps lazy.nvim, loads NvChad + custom plugins, sets up host programs (Ruby/Python/Node via mise), and configures formatters
- **Core modules**: `lua/options.lua`, `lua/mappings.lua`, `lua/autocmds.lua` - Each inherits from NvChad defaults (`require "nvchad.options"`) then adds custom overrides
- **Plugin specs**: Organized in `lua/plugins/`:
  - `init.lua` - Main plugins (formatting, AI chat, navigation, Git, editing, LSP)
  - `ai.lua` - AI tools (Codeium completions, gen.nvim Ollama chat, easypick Aider helper)
  - `test.lua` - Neotest framework with RSpec adapter
  - `linter.lua` - null-ls with Rubocop formatting and diagnostics
- **Tool configs**: `lua/configs/` - lazy.nvim config, LSP setup (html/cssls), conform formatters

### Plugin Loading Strategy

All plugins lazy-load by default (`defaults = { lazy = true }` in `lua/configs/lazy.lua`). Critical plugins like CopilotChat, hop.nvim, and vim-rails set `lazy = false` for immediate availability.

### Host Program Paths

Uses `mise` version manager (not system Ruby/Python/Node). Paths in `init.lua`:
```lua
vim.g.ruby_host_prog = '/Users/hermawan/.local/share/mise/installs/ruby/3.3.9/bin/ruby'
vim.g.python3_host_prog = '/Users/hermawan/.local/share/mise/installs/python/3.10.18/bin/python'
vim.g.node_host_prog = '/Users/hermawan/.local/share/mise/installs/node/22.18.0/bin/node'
```

When modifying these paths, check mise versions with: `mise list`

## Development Focus

**Primary language: Ruby on Rails**
- vim-rails plugin for Rails navigation
- Rubocop for linting and formatting (via null-ls)
- Dual RSpec test runners (rspec-integrated.nvim + neotest-rspec)

## Testing

### Two RSpec systems configured:

**1. RSpec Integrated** (direct runner) - Keybindings in `init.lua`:
- `<leader>tI` - Run current file
- `<leader>ti` - Run current example (test under cursor)
- `<leader>t.` - Repeat last run
- `<leader>td` - Debug current test
- `<leader>tS` - Run entire suite

**2. Neotest** (universal framework) - Keybindings in `lua/mappings.lua`:
- `<leader>tt` - Run test at cursor
- `<leader>tf` - Run current file
- `<leader>ts` - Toggle test summary panel

### Running tests manually:
```bash
bundle exec rspec                    # Run all tests
bundle exec rspec spec/models/       # Run specific directory
bundle exec rspec spec/models/user_spec.rb:12  # Run specific line
```

## Formatting & Linting

### Auto-format on save
Configured in `init.lua` via autocmd that calls `conform.format()` on `BufWritePre`.

### Formatters by filetype (lua/configs/conform.lua + init.lua):
- **Lua**: stylua
- **Python**: isort + black (sequential)
- **Rust**: rustfmt (with LSP fallback)
- **JavaScript**: prettierd or prettier (first available)

### Manual formatting:
- `<leader>ff` - Format current buffer (LSP formatter)
- `:ConformInfo` - Check which formatters are available/active

### Rubocop (Ruby):
Configured in `lua/plugins/linter.lua` via null-ls for both formatting and diagnostics. Runs automatically via null-ls LSP integration.

## AI Tools

### Four AI systems configured:

**1. Codeium** (free AI completion)
- Loads on `BufEnter`
- Toggle: `<leader>ac`

**2. gen.nvim** (local Ollama LLM for chat/refactor)
- Model: llama3 (localhost:11434)
- Trigger: `<leader>ai` or `:Gen`
- Requires Ollama running locally

**3. GitHub Copilot** (copilot.vim + CopilotChat.nvim)
- Always loaded (lazy = false)
- Copilot completions work automatically
- Chat interface available via CopilotChat commands

**4. avante.nvim** (multi-provider AI chat with UI)
- Default provider: **Gemini** (free cloud)
- Also configured:
  - **Cloud providers**: OpenAI (gpt-4o), Claude (sonnet-4), Moonshot (Kimi k2)
  - **Local provider**: Ollama (qwen2.5-coder:7b) - **FREE, no API key needed!**
- API keys via environment variables:
  - `AVANTE_GEMINI_API_KEY`
  - `AVANTE_OPEN_AI_API_KEY`
  - `AVANTE_ANTHROPIC_API_KEY`
- Supports image pasting (img-clip.nvim) and markdown rendering

### Switching AI Providers (Cloud ↔ Local)

**Quick toggle between cloud and local:**
```vim
<leader>ao                    " Toggle between Gemini (cloud) and Ollama (local)
```

**Switch to specific provider:**
```vim
:AvanteSwitch                 " Show current provider
:AvanteSwitch ollama          " Switch to local Ollama (free!)
:AvanteSwitch gemini          " Switch to Gemini (free cloud)
:AvanteSwitch claude          " Switch to Claude (requires subscription)
:AvanteSwitch openai          " Switch to OpenAI
```

**When to use Ollama (local):**
- Claude Pro subscription expired or rate limited
- No internet connection
- Want privacy (data stays on your machine)
- Experimenting without API costs

**Setup Ollama for local AI:**
```bash
# Install Ollama
brew install ollama

# Start Ollama service
ollama serve

# Pull recommended coding model (in another terminal)
ollama pull qwen2.5-coder:7b     # Fast, 4.7GB
# Or try other models:
ollama pull llama3.1             # General purpose, 4.7GB
ollama pull deepseek-coder-v2    # Coding specialist, 8.9GB
```

To change the default Ollama model, edit `lua/plugins/init.lua:120` and update the `model` field.

## Key Mappings

### Custom mappings in lua/mappings.lua:
- `;` → `:` (enter command mode from normal mode)
- `jk` → `<ESC>` (exit insert mode)
- `<leader>ai` - Open AI chat/refactor (gen.nvim with Ollama)
- `<leader>ac` - Toggle Codeium completions
- `<leader>ao` - **Toggle Avante AI provider (Cloud ↔ Local Ollama)**
- `<leader>at` - Run Aider CLI in current directory
- `<leader>tt` / `tf` / `ts` - Neotest commands (run test / file / summary)
- `<leader>ff` - Format buffer

### Inherited from NvChad (see `:NvCheatsheet`):
- `<leader>` is `<Space>`
- `<leader>th` - Change theme
- `<leader>ff` - Find files (Telescope)
- `<leader>fw` - Live grep (Telescope)
- Many more in NvChad defaults

## Plugin Modifications

### When adding new plugins:

1. Choose appropriate file in `lua/plugins/`:
   - General plugins → `init.lua`
   - AI/completion → `ai.lua`
   - Testing frameworks → `test.lua`
   - Linters/formatters → `linter.lua`

2. Follow lazy.nvim spec pattern:
```lua
{
  "author/plugin-name",
  lazy = true,              -- false for critical plugins
  event = "BufEnter",       -- or other lazy-load trigger
  dependencies = { ... },
  config = function()
    require("plugin-name").setup({})
  end,
}
```

3. If plugin needs external config, create in `lua/configs/plugin-name.lua` and reference with `opts = require "configs.plugin-name"`

### When modifying keybindings:

Edit `lua/mappings.lua` (for general) or `init.lua` (for plugin-specific like RSpec). Always use descriptive comments and maintain the `opts = { noremap = true, silent = true }` pattern.

## Common Issues

### "Ruby host not found" errors
Check mise installation and update path in `init.lua:46` to match `mise which ruby`.

### Tests not running
- Ensure you're in a Rails project with `bundle install` completed
- Check RSpec is in Gemfile
- Neotest requires treesitter parser: `:TSInstall ruby`

### Formatters not working
- Check tool is installed: `:Mason` or `which stylua`
- Verify in `:ConformInfo`
- Format-on-save is global; disable by commenting `init.lua:63-68`

### Ollama/gen.nvim not responding
- Ensure Ollama is running: `ollama serve`
- Verify model is pulled: `ollama pull llama3`
- Check localhost:11434 is accessible

## File Organization

```
~/.config/nvim/
├── init.lua                   # Bootstrap, host paths, hop/conform setup, RSpec keybindings
├── lazy-lock.json             # Plugin version lockfile (commit this)
├── lua/
│   ├── chadrc.lua             # NvChad theme config (currently: onedark)
│   ├── options.lua            # Neovim options (extends nvchad.options)
│   ├── mappings.lua           # Keybindings (extends nvchad.mappings)
│   ├── autocmds.lua           # Autocommands (extends nvchad.autocmds)
│   ├── plugins/
│   │   ├── init.lua           # Main plugins (conform, copilot, avante, fugitive, etc.)
│   │   ├── ai.lua             # AI tools (codeium, gen.nvim, easypick)
│   │   ├── test.lua           # Testing (neotest + rspec adapter)
│   │   └── linter.lua         # Linting (null-ls + rubocop)
│   └── configs/
│       ├── lazy.lua           # Lazy.nvim performance config
│       ├── lspconfig.lua      # LSP servers (html, cssls)
│       └── conform.lua        # Formatter configurations
└── pack/                      # External tools (ignore)
```

## Updating Configuration

### Sync plugins after changes:
```bash
nvim
:Lazy sync
```

### Update NvChad:
```bash
:Lazy update NvChad
```

### Check plugin status:
```bash
:Lazy
```

### Regenerate lockfile after plugin changes:
Lockfile auto-updates on `:Lazy sync`. Commit `lazy-lock.json` for reproducibility.
- save