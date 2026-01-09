# 🚀 My Neovim Setup - NvChad + 5 AI Integrations

> A pragmatic Neovim configuration built on NvChad v2.5 with multiple AI assistants, zero vendor lock-in, and budget-friendly fallbacks.

![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![NvChad](https://img.shields.io/badge/NvChad-v2.5-blue?style=for-the-badge)

## ✨ What Makes This Special?

**Never be stuck without AI assistance.** When Claude goes down, I don't panic—I just switch to my backup, then my backup's backup.

This config runs **5 different AI integrations** with a layered fallback strategy:
- 💰 **Premium tier** ($30-40/mo) - Claude Code + Copilot when budget allows
- 💵 **Budget tier** ($0-10/mo) - Free Gemini API + Codeium when money's tight
- 🆓 **Free tier** ($0/mo) - Local Ollama models when you're broke

**You can still code with AI assistance without spending a dime.**

## 🤖 AI Integrations (The Full Arsenal)

| Tool | Purpose | Cost | Keybinding |
|------|---------|------|------------|
| **Claude Code** | Primary AI assistant with terminal split | ~$20/mo | `<leader>cc` |
| **Avante.nvim** | Multi-provider chat (Claude/GPT/Gemini/Ollama) | $0-$20/mo | `:AvanteSwitch` |
| **OpenCode** | Right-side AI assistant (like Copilot Chat) | Free | `<leader>oo` |
| **GitHub Copilot** | Inline code completions | $10/mo | Auto |
| **Codeium** | Free AI completions (always-on backup) | Free | `<leader>ac` |

**Plus:** Local Ollama support for fully offline AI (`<leader>ai`)

## 🎯 Quick Start

### Prerequisites

```bash
# Install Neovim 0.10+
brew install neovim

# Install mise (version manager for Ruby/Python/Node)
brew install mise

# Install Claude Code CLI
npm install -g @anthropic-ai/claude-code

# Install Ollama (for local AI)
brew install ollama
```

### Installation

```bash
# 1. Backup your existing config
mv ~/.config/nvim ~/.config/nvim.backup

# 2. Clone this repo
git clone https://github.com/mirzalazuardi/nvim_setup ~/.config/nvim

# 3. Start Neovim (plugins will install automatically)
nvim

# 4. Inside Neovim, sync plugins
:Lazy sync
```

### Setup API Keys (Optional)

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
# For Avante.nvim multi-provider support
export AVANTE_ANTHROPIC_API_KEY="your-claude-api-key"  # Optional: Claude
export AVANTE_GEMINI_API_KEY="your-gemini-api-key"     # Free tier available!
export AVANTE_OPEN_AI_API_KEY="your-openai-api-key"    # Optional: GPT-4

# Reload shell
source ~/.zshrc
```

**No API keys?** No problem! Use the free tier:
- Codeium (always free)
- Local Ollama models (`ollama pull llama3.1`)
- Gemini free tier

## ⌨️ Key Mappings

### AI Tools
| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle Claude Code terminal |
| `<leader>cs` | Send selection to Claude (visual mode) |
| `<leader>ca` | Accept Claude's diff |
| `<leader>cd` | Deny Claude's diff |
| `<leader>oo` | Toggle OpenCode |
| `<leader>ai` | Chat with local Ollama |
| `<leader>ac` | Toggle Codeium |
| `<leader>ao` | Toggle Avante provider (Cloud ↔ Ollama) |

### Testing (Rails/RSpec)
| Key | Action |
|-----|--------|
| `<leader>tI` | Run current spec file |
| `<leader>ti` | Run spec under cursor |
| `<leader>t.` | Repeat last test |

### General
| Key | Action |
|-----|--------|
| `;` | Enter command mode |
| `jk` | Exit insert mode |
| `<leader>ff` | Format buffer |
| `<leader>fw` | Live grep (Telescope) |

**Full keybindings:** `:NvCheatsheet`

## 💡 Budget-Friendly Workflows

### Scenario 1: I Have Budget ($30-40/month)
```vim
<leader>cc          " Use Claude Code for complex problems
<leader>cs          " Send selection to Claude
:Copilot            " Inline completions
```

### Scenario 2: Budget Is Tight ($0-10/month)
```vim
<leader>oo          " OpenCode with free Gemini
:AvanteSwitch gemini " Use Gemini free tier
<leader>ac          " Codeium completions
```

### Scenario 3: I'm Broke ($0/month)
```bash
# Start Ollama locally
ollama serve

# In another terminal, pull a model
ollama pull llama3.1
```

```vim
<leader>ao          " Switch to local Ollama
<leader>ai          " Chat with local model
<leader>ac          " Codeium completions
```

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point + host paths
├── lua/
│   ├── options.lua             # Neovim options
│   ├── mappings.lua            # Keybindings
│   ├── autocmds.lua            # Autocommands
│   ├── plugins/
│   │   ├── init.lua            # Main plugins (OpenCode, Avante, Copilot, etc.)
│   │   ├── ai.lua              # AI tools (Claude Code, Codeium, gen.nvim)
│   │   └── linter.lua          # Linting (Rubocop, null-ls)
│   └── configs/
│       ├── lazy.lua            # Lazy.nvim config
│       ├── lspconfig.lua       # LSP servers
│       └── conform.lua         # Formatters
├── CLAUDE.md                   # Detailed documentation
└── lazy-lock.json              # Plugin versions
```

## 🛠️ Tech Stack

### Core
- **NvChad v2.5** - Blazing fast Neovim config
- **lazy.nvim** - Plugin manager with lazy loading
- **mise** - Version manager for Ruby/Python/Node

### AI Integration
- **claudecode.nvim** - Claude Code CLI integration
- **avante.nvim** - Multi-provider AI chat
- **opencode.nvim** - Right-side AI assistant
- **copilot.vim** - GitHub Copilot
- **codeium.nvim** - Free AI completions
- **gen.nvim** - Local Ollama chat

### Development (Ruby on Rails Focus)
- **vim-rails** - Rails navigation
- **null-ls** - Rubocop linting
- **rspec-integrated.nvim** - Test runner
- **conform.nvim** - Auto-formatting

### Utilities
- **telescope.nvim** - Fuzzy finder
- **vim-fugitive** - Git integration
- **hop.nvim** - Fast navigation
- **Comment.nvim** - Easy commenting

## 🎨 Philosophy

### 1. Never Be Vendor-Locked
AI services go down. Rate limits hit. Subscriptions expire. Always have a backup.

### 2. Budget Flexibility
Scale from $0 to $40/month based on your needs. Never stop coding because you can't afford tools.

### 3. Best Tool for the Job
- **Claude Code** for complex refactoring
- **Copilot** for boilerplate
- **Local Ollama** for privacy-sensitive work
- **Codeium** when everything else fails

### 4. Lazy Loading Everything
Plugins only load when needed. Fast startup times, low memory usage.

## 📚 Documentation

- **[CLAUDE.md](./CLAUDE.md)** - Complete architecture guide
- **[SECURITY-CHECKLIST.md](./SECURITY-CHECKLIST.md)** - How to safely push to GitHub
- **Version managers:** [VERSION_MANAGER_GUIDE.md](./VERSION_MANAGER_GUIDE.md)
- **AI switching:** [SPEC_KIT_AI_SWITCHING.md](./SPEC_KIT_AI_SWITCHING.md)

## 🤝 Contributing

Found a bug? Have a suggestion? Feel free to:
1. Fork this repo
2. Create a feature branch
3. Submit a pull request

Or just open an issue!

## 📝 Credits

- **[NvChad](https://github.com/NvChad/NvChad)** - Amazing Neovim config framework
- **[LazyVim starter](https://github.com/LazyVim/starter)** - Inspiration for plugin structure
- **Anthropic** - Claude Code CLI
- **All the plugin authors** - You make Neovim amazing

## 📄 License

MIT License - Feel free to use this config however you like!

---

**Questions?** Hit me up on:
- GitHub: [@mirzalazuardi](https://github.com/mirzalazuardi)
- Twitter: [@hermawan](https://twitter.com/hermawan)

**Star this repo if it helped you!** ⭐

---

*Last updated: January 9, 2026 • Built with NvChad v2.5*
