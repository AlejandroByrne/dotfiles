# 🚀 My Neovim Giga Chad Setup

Lightning-fast Neovim configuration for full-stack development.

## Features
- 🔍 Telescope fuzzy finding
- 🤖 AI-powered completion (Codeium)
- 📁 Modern file explorer
- 🚀 LSP for all major languages
- ⚡ Harpoon for instant file switching
- 🎨 Clean, minimal UI

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```
### System Dependencies Installed
# Terminal
- iTerm2

# Core tools
- neovim
- git
- ripgrep
- fd
- fzf

# Language runtimes
- node
- python@3.11
- clang (via Xcode tools)

# Additional tools
- cmake
- make
- lazygit

# Python/Node providers
- pynvim (pip3 install pynvim)
- neovim (npm install -g neovim)

### Plugins installed
Plugin Manager

lazy.nvim - Modern plugin manager


File Navigation

neo-tree.nvim - File explorer (<leader>e)
telescope.nvim - Fuzzy finder (<leader>ff, <leader>fg)
harpoon - Quick file switching (Ctrl+h/t/n/s)


LSP & Completion

lsp-zero.nvim - Easy LSP setup
nvim-lspconfig - LSP configurations
mason.nvim - LSP installer
mason-lspconfig.nvim - Mason LSP bridge
nvim-cmp - Completion engine
cmp-nvim-lsp - LSP completion source
LuaSnip - Snippet engine
lspkind.nvim - Completion icons


AI Assistance

codeium.vim - Free AI completion (Ctrl+g to accept)


Git Integration

lazygit.nvim - Git UI (<leader>gg)


Quality of Life

nvim-autopairs - Auto close brackets
better-escape.nvim - Exit insert with jk or jj

### Core settings:
-- Leader key: Space
-- Indent: 2 spaces default, 4 for C/C++/Python
-- Line numbers: Relative
-- Mouse: Enabled
-- Clipboard: System clipboard

## Keybindings cheat sheet
NAVIGATION
<leader>e        - Toggle file explorer
<leader>ff       - Find files
<leader>fg       - Live grep
<leader>w        - Save file
Ctrl+h/j/k/l     - Navigate windows

HARPOON
<leader>a        - Add file to harpoon
Ctrl+e           - Show harpoon menu
Ctrl+h/t/n/s     - Jump to harpoon files 1-4

LSP
K                - Hover documentation
gd               - Go to definition
gr               - Find references
<leader>rn       - Rename (when added)

GIT
<leader>gg       - LazyGit

AI COMPLETION
Ctrl+g           - Accept Codeium suggestion
Ctrl+]           - Next suggestion
Ctrl+[           - Previous suggestion

INSERT MODE
jk or jj         - Exit insert mode
Tab              - Next completion item
Shift+Tab        - Previous completion item

### Language servers installed
- pyright
- lua_ls
- clangd
