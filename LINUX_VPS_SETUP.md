# Linux VPS Setup Guide

This guide covers installing this Neovim config on a lightweight VPS for PHP, JavaScript, Ruby, and Python development.

## Prerequisites

### System Requirements
- Ubuntu 20.04+ / Debian 11+
- 1GB+ RAM
- Internet connection

### Install Base Dependencies

```bash
apt update && apt upgrade -y
apt install -y git curl python3 python3-pip nodejs npm unzip zip
```

## Install Neovim

```bash
# Ubuntu 22.04+ has neovim in apt
apt install neovim

# For older versions, use the appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mv nvim-linux64 /opt/nvim
ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz
```

Verify:
```bash
nvim --version
```

## Install mise (Version Manager)

```bash
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

Install languages:
```bash
mise use -g node@22 python@3.10 ruby@3.3 php@latest

# Enable uv for fast Python package management
mise settings python.uv = true
```

## Install PHP Tools

```bash
# PHP is already in apt, but for newer versions:
apt install -y php php-cli php-xml php-mbstring php-curl php-zip

# PHP CodeSniffer (for linting)
composer global require squizlabs/php_codesniffer

# PHP CS Fixer
composer global require friendsofphp/php-cs-fixer

# phpactor (LSP)
composer global require phpactor/phpactor
```

## Install Node Tools

```bash
# Already installed via mise
npm install -g prettierd typescript typescript-language-server
```

## Install Ruby Tools

```bash
# Installed via mise
gem install rubocop
```

## Install Python Tools (uv)

```bash
# uv is automatically installed with mise Python
# Install common tools via uv
uv tool install ruff
uv tool install black
uv tool install isort
```

## Install the Nvim Config

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

# Clone this repo
git clone https://github.com/mirzalazuardi/nvim_setup ~/.config/nvim

# Checkout linux-vps branch
cd ~/.config/nvim && git checkout linux-vps

# Start neovim (plugins auto-install)
nvim +Lazy sync
```

## LSP Setup per Language

### TypeScript/JavaScript
LSP is included via NvChad. Treesitter auto-installs parsers.

### Python
Uses `pyright` LSP (included in NvChad). Python formatting via `ruff` + `black`:
```bash
uv tool install ruff black isort
```

### PHP
Uses `phpactor` LSP:
```bash
# Ensure composer global bin is in PATH
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

In Neovim, verify LSP:
```
:LspInfo
```

### Ruby
Rubocop runs via nvim-lint:
```bash
gem install rubocop
```

## Key Differences: macOS vs Linux

| Feature | macOS | Linux VPS |
|--------|-------|-----------|
| mise path | `~/.local/share/mise/installs/` | `~/.local/share/mise/installs/` |
| Node default | `/usr/local/bin` | `/usr/local/bin` |
| PHP LSP | phpactor | phpactor |
| Formatters | macOS tools | Linux equivalents |

## Common Issues

### "LSP not starting"
```bash
# Check mason packages
nvim +LspInstallStatus

# Manual install
nvim + MasonInstall phpactor
```

### "Formatter not found"
```bash
# Check conform status
nvim +ConformInfo
```

### " Treesitter parser missing"
```bash
nvim +TSUpdate
```

## Testing

```bash
# Test PHP file
nvim test.php
# Should show LSP diagnostics

# Test JS file
nvim test.js
# Should show LSP + prettier

# Test Ruby file
nvim test.rb
# Should show rubocop diagnostics
```