# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

DotMatrix is a dotfiles management repository that provides environment-ready configuration blueprints for consistent development environments across machines. It uses a modular structure with environment variable sourcing and organized application configs.

## Architecture

### Directory Structure

- **`.env/`**: Environment variables (gitignored) containing host, SSH, and user variables
  - `nodes`: Host definitions (PROX, CPANEL, DEV, BM, etc.)
  - `ssh`: SSH port configurations
  - `users`: User account variables

- **`ENV/`**: Template versions of environment files (tracked in git)

- **`app-configs/`**: Application-specific configuration files
  - `lazy-nvim/`: LazyVim Neovim configuration (lua-based)
  - `custom-nvim/`: Alternative custom Neovim setup
  - `ghostty/`: Ghostty terminal emulator configs
  - `kitty/`: Kitty terminal emulator configs
  - `starship/`: Starship prompt configuration (Gruvbox theme)
  - `tmux/`: tmux configuration (prefix: C-a, mouse enabled)

- **`shell-configs/`**: Shell configuration with modular loading
  - `bash/`: Bash configs with `bashrc` and `bashrc.d/` directory
  - `zsh/`: ZSH configs with `zshrc` and `zshrc.d/` directory

- **`Themes/`**: Color schemes and wallpapers
  - `GruvBox/`: Gruvbox theme files (.conf, .css)
  - `Wallpapers/`: Background images

- **`CustomVim/`**: Legacy vim configurations

### Configuration Loading Pattern

Both bash and zsh use a modular configuration pattern:

**Bash**: Sources all `.sh` files from `~/.bashrc.d/`
```bash
for file in ~/.bashrc.d/*.sh; do
  [ -r "$file" ] && source "$file"
done
```

**ZSH**: Sources all `.zsh` files from `~/.zshrc.d/` with numeric prefixes for load order
- `00-env.zsh`: Environment variables (EDITOR, PATH)
- `05-functions.zsh`: Custom functions including venv management
- `06-tmux.zsh`: tmux integration
- `10-history.zsh`: History settings
- `20-alias.zsh`: Command aliases
- `30-keychain.zsh`: SSH keychain integration
- `99-gh.zsh`: GitHub CLI completions

### Environment Variable System

The repository uses a secret management pattern:
- **ZSH**: `05-functions.zsh` auto-detects git root and sources all `.env/` files
- **ZSH**: `20-alias.zsh` also sources environment files from `~/GitHub/DotMatrix/.env/`
- Keeps sensitive variables in `.env/` directory (gitignored)
- Provides templates in `ENV/` directory for reference structure

### ZSH Plugin Management

Uses `zinit` plugin manager with:
- Syntax highlighting, autosuggestions, completions
- Oh-My-Zsh snippets (git, sudo, archlinux, command-not-found)

### Neovim Configuration

**lazy-nvim**: LazyVim-based configuration
- Entry: `init.lua`
- Config: `lua/config/` (autocmds, keymaps, lazy, options)
- Plugins: `lua/plugins/` (bufferline, colorscheme, snacks)
- Lock file: `lazy-lock.json`

### Theming

All configurations use Gruvbox color scheme:
- Starship prompt: Custom Gruvbox format with icons
- Terminal themes: `Themes/GruvBox/`
- Neovim: Gruvbox colorscheme plugin

## Deployment

### Automated Deployment (Recommended)

Run the deployment script to automatically symlink all configurations:
```bash
./deploy.sh
```

This script:
- Creates timestamped backups of existing configs in `~/.dotfiles-backup-<timestamp>/`
- Symlinks ZSH configs (`~/.zshrc`, `~/.zshrc.d/`)
- Symlinks app configs (Neovim, tmux, Kitty, Starship)
- Checks for `.env/` directory and warns if missing
- Bash configs are commented out in the script (ZSH is primary shell)

### Initial Setup

1. Clone repository (typically to `~/GitHub/DotMatrix`)
2. Create environment variables:
   ```bash
   mkdir -p .env
   cp ENV/nodes .env/nodes
   cp ENV/ssh .env/ssh
   cp ENV/users .env/users
   # Edit files in .env/ with your actual host IPs, ports, and usernames
   ```
3. Run deployment script: `./deploy.sh`
4. Reload shell: `exec zsh`
5. On first ZSH launch, `zinit` will auto-install and set up plugins

### What Gets Deployed

By default, the script symlinks:
- **ZSH**: `~/.zshrc` → `shell-configs/zsh/zshrc`, `~/.zshrc.d/` → `shell-configs/zsh/zshrc.d/`
- **Neovim**: `~/.config/nvim/` → `app-configs/lazy-nvim/`
- **Kitty**: `~/.config/kitty/` → `app-configs/kitty/`
- **Starship**: `~/.config/starship.toml` → `app-configs/starship/starship.toml`
- **tmux**: `~/.tmux.conf` → `app-configs/tmux/tmux.conf`

Commented out in `deploy.sh` (uncomment if needed):
- Bash configs (`~/.bashrc`, `~/.bashrc.d/`)
- Ghostty terminal configs

### Re-deploying or Updating Symlinks

To redeploy after pulling changes or modifying `deploy.sh`:
```bash
./deploy.sh
```

The script automatically backs up existing configs before creating new symlinks.

## Development Workflow

### Managing Configurations

When modifying shell configs:
1. Edit files in appropriate `bashrc.d/` or `zshrc.d/` subdirectory
2. Use numeric prefixes in zshrc.d to control load order (00, 05, 10, etc.)
3. Reload shell or source the main rc file to test

### Environment Variables

1. Never commit files in `.env/` directory
2. Use `ENV/` templates as reference for structure
3. Environment variables are auto-loaded by zsh via `05-functions.zsh`

### Virtual Environment Management

ZSH includes custom functions for managing Python venvs:
- `load_all_venvs`: Adds all `~/GitHub/*/.venv/bin` to PATH
- `unload_all_venvs`: Removes loaded venv paths from PATH

### Testing Changes

After modifying configurations:
1. Changes are live immediately (configs are symlinked)
2. For shell configs: `source ~/.zshrc` or `exec zsh`
3. For tmux: `tmux source-file ~/.tmux.conf` or restart tmux
4. For Neovim: Restart nvim or use `:Lazy sync` for plugin changes

## Key Configuration Details

### tmux
- Prefix: `C-a` (not default `C-b`)
- Mouse mode: enabled
- Window and pane indexing: starts at 1 (not 0)
- Auto-renumbers windows on close
- Terminal: tmux-256color with true color support

### Starship Prompt
- Custom Gruvbox format with powerline symbols
- Shows: directory, git branch/status, language versions (Node, Rust, Go, PHP), time
- Directory truncation at 3 levels

### Shell Integrations
- Starship prompt (bash only), custom PS1 (zsh)
- Keychain for SSH agent management (zsh)
- Case-insensitive tab completion (both shells)
