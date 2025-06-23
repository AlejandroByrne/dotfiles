#!/usr/bin/env bash

echo "🚀 Installing Neovim Chad Setup..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "📦 macOS detected, installing dependencies..."
    
    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install dependencies
    brew install neovim git ripgrep fd fzf node python@3.11 cmake make lazygit
    
    # Install iTerm2
    brew install --cask iterm2
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Linux detected..."
    # Add Linux install commands based on distro
    sudo apt-get update
    sudo apt-get install -y neovim git ripgrep fd-find fzf nodejs npm python3-pip cmake make
    
    # Install lazygit
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
fi

# Install Python/Node providers
pip3 install pynvim
npm install -g neovim

# Backup existing config
if [ -d ~/.config/nvim ]; then
    echo "📦 Backing up existing config..."
    mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

# Create symlink
echo "🔗 Creating symlinks..."
mkdir -p ~/.config
ln -sf $(pwd)/nvim/.config/nvim ~/.config/nvim

# Install lazy.nvim
echo "📦 Installing lazy.nvim..."
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim

echo "✅ Installation complete!"
echo "📝 Now open nvim and wait for plugins to install"
echo "📝 Then run :Mason to verify LSP servers"
echo "📝 Finally run :Codeium Auth to setup AI completion"
