# Version Manager Guide: mise + nvm Setup

This guide explains how your system manages multiple version managers (mise + nvm) and how to avoid conflicts with Neovim.

## Current Setup

You have **TWO** version managers installed:

### 1. **mise** (Modern, Multi-language)
- Manages: Ruby, Python, Node, Rust, Lua, etc.
- Config: `~/.config/mise/config.toml`
- Purpose: **Primary version manager** for modern tools
- Configured versions:
  - `node: lts` (22.18.0)
  - `python: 3.10.18`
  - `ruby: 3.3.9`

### 2. **nvm** (Node Version Manager)
- Manages: **Only Node.js**
- Purpose: Legacy Node versions not available in mise
- Installed versions: `v14.21.3` (older version)

## The Problem (Now Fixed!)

### Previous Issues:
1. **Version Conflict**: Neovim hardcoded paths to mise's node 22.18.0, but nvm's v14.21.3 was active in shell
2. **GEM_HOME Mismatch**: `.zshrc` pointed to ruby 3.4.4, but mise configured 3.3.9
3. **mise Not Active**: mise activation was commented out in `.zshrc`

### How We Fixed It:
1. **Dynamic Version Detection** in `init.lua`:
   - Neovim now calls `mise where <tool>` to find active versions
   - Falls back to hardcoded paths if mise unavailable
   - No more crashes from version mismatches!

2. **Dynamic GEM_HOME** in `.zshrc`:
   - Automatically detects mise's active Ruby version
   - Sets GEM_HOME to match current Ruby version
   - Prevents gem installation to wrong locations

## When to Use Each Version Manager

### Use **mise** for:
- ✅ Modern Node.js (v16+, LTS versions)
- ✅ All Ruby development (Rails, gems)
- ✅ All Python development
- ✅ Rust, Lua, Go, etc.
- ✅ **Neovim** (uses mise by default)

### Use **nvm** for:
- ✅ Old Node.js projects requiring v14.x or older
- ✅ Projects with strict Node version requirements not in mise

## Switching Between Version Managers

You have custom commands in your `.zshrc`:

### Check Current Status:
```bash
vm-status              # Show which manager is active
vm-info                # Detailed info for all tools
vm-info-mise           # Show mise installations
vm-info-nvm            # Show nvm installations
```

### Switch Active Manager:
```bash
use-mise               # Activate mise (recommended for Neovim)
use-nvm                # Activate nvm (for legacy Node projects)
```

**IMPORTANT**: After switching, reload your shell:
```bash
exec zsh               # or: source ~/.zshrc
```

## Current State (After Fixes)

```
┌─────────────────────────────────────────────────────┐
│ Shell Environment                                   │
│ • nvm is ACTIVE (node v14.21.3)                     │
│ • mise is INACTIVE (commented in .zshrc line 12)    │
├─────────────────────────────────────────────────────┤
│ Neovim Environment (ISOLATED)                       │
│ • Uses mise versions ONLY (via init.lua)            │
│ • node:   22.18.0 (from mise)                       │
│ • python: 3.10.18 (from mise)                       │
│ • ruby:   3.3.9   (from mise)                       │
│ • Dynamically detects versions on startup           │
└─────────────────────────────────────────────────────┘
```

## Recommendations

### For Daily Development:
1. **Keep mise active** in shell:
   ```bash
   use-mise
   exec zsh
   ```

2. **Use nvm only when needed**:
   ```bash
   # In a legacy Node.js project
   use-nvm
   exec zsh
   nvm use 14.21.3
   ```

3. **Neovim always uses mise** regardless of shell setup (automatically handled)

### Avoiding Conflicts:

#### ❌ DON'T:
- Have both mise AND nvm active simultaneously
- Hardcode version numbers in configs
- Manually set GEM_HOME (now dynamic)

#### ✅ DO:
- Use `use-mise` or `use-nvm` to switch
- Let Neovim auto-detect versions (already configured)
- Keep `~/.config/mise/config.toml` updated when changing versions

## Troubleshooting

### "Ruby host not found" in Neovim
```bash
# Check mise Ruby installation
mise where ruby

# If missing, install it
mise install ruby@3.3.9
```

### "Node module not found" in Neovim plugins
```bash
# Verify Neovim is using mise's Node
# Inside Neovim:
:echo g:node_host_prog

# Should show: /Users/hermawan/.local/share/mise/installs/node/22.18.0/bin/node
```

### Gems installing to wrong location
```bash
# Check GEM_HOME
echo $GEM_HOME

# Should match mise's active Ruby version
# If wrong, reload shell:
source ~/.zshrc
```

### Wrong Node version in shell vs Neovim
This is **NORMAL**! Your shell might use nvm (v14.21.3) while Neovim uses mise (v22.18.0).

To sync them:
```bash
use-mise
exec zsh
```

## Files Modified

1. **`~/.config/nvim/init.lua`** (lines 4-24, 68-85)
   - Added dynamic version detection
   - Graceful fallbacks for missing versions

2. **`~/.zshrc`** (lines 53-62)
   - Dynamic GEM_HOME based on mise's active Ruby

## Testing Your Setup

Run these commands to verify everything works:

```bash
# 1. Check shell versions
node --version          # Should show nvm or mise version
python3 --version       # Should show mise version
ruby --version          # Should show mise version

# 2. Check Neovim can start
nvim --version

# 3. Inside Neovim, check host programs
nvim -c ':echo g:node_host_prog' -c ':echo g:python3_host_prog' -c ':echo g:ruby_host_prog' -c ':q'

# 4. Test a plugin that uses Node (e.g., Copilot)
nvim -c ':Copilot status' -c ':q'
```

## Need to Change Versions?

### Update mise versions:
```bash
# Edit config
nvim ~/.config/mise/config.toml

# Change versions, e.g.:
[tools]
ruby = "3.4.4"        # Update to newer Ruby
node = "20.10.0"      # Pin specific Node version

# Install new versions
mise install

# Neovim will auto-detect on next startup!
```

### Add Node version to nvm:
```bash
use-nvm
exec zsh
nvm install 16.20.0
nvm use 16.20.0
```

---

**Summary**: Your Neovim config is now **version-manager agnostic** and will work whether you have mise or nvm active in your shell. The dynamic detection prevents crashes and keeps everything in sync! 🎉
