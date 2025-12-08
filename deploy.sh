#!/usr/bin/env bash
#
# DotMatrix Deployment Script
# Symlinks configuration files from this repository to their proper locations
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Track if any backups were made
BACKUP_MADE=false

echo -e "${BLUE}=== DotMatrix Deployment ===${NC}"
echo -e "Repository: ${SCRIPT_DIR}"
echo ""

# Function to print messages
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to backup existing file or directory
backup() {
    local target=$1

    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ "$BACKUP_MADE" = false ]; then
            mkdir -p "$BACKUP_DIR"
            info "Created backup directory: $BACKUP_DIR"
            BACKUP_MADE=true
        fi

        local backup_path="$BACKUP_DIR/$(basename "$target")"
        mv "$target" "$backup_path"
        warning "Backed up existing $(basename "$target") to $backup_path"
    fi
}

# Function to create symlink
create_symlink() {
    local source=$1
    local target=$2
    local description=$3

    # Check if source exists
    if [ ! -e "$source" ]; then
        error "Source does not exist: $source"
        return 1
    fi

    # Create parent directory if needed
    local parent_dir=$(dirname "$target")
    if [ ! -d "$parent_dir" ]; then
        mkdir -p "$parent_dir"
        info "Created directory: $parent_dir"
    fi

    # Backup existing file/directory
    backup "$target"

    # Create symlink
    ln -sf "$source" "$target"
    success "Linked $description"
}

echo -e "${BLUE}=== Shell Configuration ===${NC}"

# ZSH Configuration
create_symlink \
    "$SCRIPT_DIR/shell-configs/zsh/zshrc" \
    "$HOME/.zshrc" \
    "ZSH config (~/.zshrc)"

create_symlink \
    "$SCRIPT_DIR/shell-configs/zsh/zshrc.d" \
    "$HOME/.zshrc.d" \
    "ZSH config directory (~/.zshrc.d/)"

# Bash Configuration (optional, commented out since you mainly use ZSH)
# Uncomment these lines if you want to deploy bash configs too:
# create_symlink \
#     "$SCRIPT_DIR/shell-configs/bash/bashrc" \
#     "$HOME/.bashrc" \
#     "Bash config (~/.bashrc)"
#
# create_symlink \
#     "$SCRIPT_DIR/shell-configs/bash/bashrc.d" \
#     "$HOME/.bashrc.d" \
#     "Bash config directory (~/.bashrc.d/)"

echo ""
echo -e "${BLUE}=== Application Configuration ===${NC}"

# Neovim (LazyVim)
create_symlink \
    "$SCRIPT_DIR/app-configs/lazy-nvim" \
    "$HOME/.config/nvim" \
    "Neovim config (~/.config/nvim/)"

# Starship prompt
create_symlink \
    "$SCRIPT_DIR/app-configs/starship/starship.toml" \
    "$HOME/.config/starship.toml" \
    "Starship prompt (~/.config/starship.toml)"

# tmux
create_symlink \
    "$SCRIPT_DIR/app-configs/tmux/tmux.conf" \
    "$HOME/.tmux.conf" \
    "tmux config (~/.tmux.conf)"

# Ghostty terminal (commented out - using Kitty instead)
# Uncomment these lines if you want to deploy Ghostty configs:
# create_symlink \
#     "$SCRIPT_DIR/app-configs/ghostty" \
#     "$HOME/.config/ghostty" \
#     "Ghostty terminal (~/.config/ghostty/)"

# Kitty terminal
create_symlink \
    "$SCRIPT_DIR/app-configs/kitty" \
    "$HOME/.config/kitty" \
    "Kitty terminal (~/.config/kitty/)"

echo ""
echo -e "${BLUE}=== Environment Variables ===${NC}"

# Check if .env directory exists
if [ ! -d "$SCRIPT_DIR/.env" ]; then
    warning "No .env directory found"
    info "Create .env directory and populate with your environment variables"
    info "Use ENV/ directory as templates:"
    echo "  mkdir -p $SCRIPT_DIR/.env"
    echo "  cp $SCRIPT_DIR/ENV/* $SCRIPT_DIR/.env/"
    echo "  # Then edit the files in .env/ with your actual values"
else
    success ".env directory exists"
fi

echo ""
echo -e "${GREEN}=== Deployment Complete! ===${NC}"

if [ "$BACKUP_MADE" = true ]; then
    echo ""
    echo -e "${YELLOW}Note:${NC} Original files were backed up to:"
    echo -e "  $BACKUP_DIR"
fi

echo ""
echo "Next steps:"
echo "  1. Review the symlinks: ls -la ~/ ~/.config/"
echo "  2. If .env doesn't exist, copy templates and populate values"
echo "  3. Reload your shell: exec zsh"
echo "  4. For ZSH plugins, zinit will auto-install on first shell launch"
echo ""
