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

### Configuration Loading Pattern

Both bash and zsh use a modular configuration pattern:

**Bash**: Sources all `.sh` files from `~/.bashrc.d/`
```bash
for file in ~/.bashrc.d/*.sh; do
  [ -r "$file" ] && source "$file"
done
```

**ZSH**: Sources all `.zsh` files from `~/.zshrc.d/` with numeric prefixes for load order
- `00-env.zsh`: Environment variables (EDITOR, PATH) and ProbeWeaver venv activation
- `05-functions.zsh`: Custom functions including venv management and git-root env loading
- `06-tmux.zsh`: TERM handling and SSH wrapper for network device compatibility
- `10-history.zsh`: History settings
- `20-alias.zsh`: Command aliases
- `30-keychain.zsh`: SSH keychain integration
- `99-gh.zsh`: GitHub CLI completions

**Load Order Significance**:
- Files are loaded alphabetically, so numeric prefixes control execution order
- `00-env.zsh` loads first (environment variables needed by other modules)
- `05-functions.zsh` loads early (functions used in later modules)
- `99-gh.zsh` loads last (GitHub CLI completions, less critical)

### Environment Variable System

The repository uses an intelligent secret management pattern:
- **Git Root Detection**: `05-functions.zsh` auto-detects the git repository root and sources all files from `<git-root>/.env/`
- This works from any directory within the DotMatrix git repository
- Only readable files in `.env/` directory are sourced
- `.env/` directory is gitignored for security
- `ENV/` directory provides templates for reference structure

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

### Prerequisites

Before deploying DotMatrix configurations:
1. ProbeWeaver repository must be cloned to `~/Documents/GitHub/ProbeWeaver/`
2. ProbeWeaver's Python virtual environment must be created:
   ```bash
   cd ~/Documents/GitHub/ProbeWeaver
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -e ".[dev]"
   ```
3. `zinit` will auto-install on first ZSH launch (no manual installation needed)

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
- Starship prompt available but currently disabled in ZSH (custom PS1 used instead)
- Starship can be enabled by uncommenting `eval "$(starship init zsh)"` in zshrc
- Custom ZSH PS1: ` [<directory>]: ` with cyan formatting
- Keychain for SSH agent management (zsh)
- Case-insensitive tab completion (both shells)

### Cross-Project Integration

**ProbeWeaver Virtual Environment**: The ZSH configuration automatically activates the ProbeWeaver Python virtual environment in `00-env.zsh`:
```zsh
source $HOME/Documents/GitHub/ProbeWeaver/.venv/bin/activate
```
This means:
- ProbeWeaver CLI tools (`weaver`/`probeweaver`) are immediately available in the shell
- Requires ProbeWeaver repository to exist at `~/Documents/GitHub/ProbeWeaver/`
- Requires ProbeWeaver's `.venv` to be created before deploying DotMatrix configs
- If you don't use ProbeWeaver, comment out line 6 in `shell-configs/zsh/zshrc.d/00-env.zsh`

### SSH and TERM Compatibility

The `06-tmux.zsh` module provides intelligent TERM handling:
- **Inside tmux**: Sets `TERM=tmux-256color`
- **Outside tmux**: Preserves Kitty's native `xterm-kitty` or defaults to `xterm-256color`
- **SSH wrapper**: Automatically downgrades TERM for compatibility
  - `xterm-kitty`, `tmux-256color`, and `*-direct` become `xterm-256color` for SSH
  - Network devices (cisco, juniper, switch, router) get `xterm` for maximum compatibility
  - Override with `TERM_SAFE` environment variable if needed

This prevents broken characters and display issues when SSHing to servers and network devices.

## Troubleshooting

### ProbeWeaver venv activation fails

If you see errors when starting ZSH about ProbeWeaver's venv:
1. Ensure ProbeWeaver repository exists at `~/Documents/GitHub/ProbeWeaver/`
2. Create the virtual environment:
   ```bash
   cd ~/Documents/GitHub/ProbeWeaver
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -e ".[dev]"
   ```
3. If you don't use ProbeWeaver, comment out line 6 in `shell-configs/zsh/zshrc.d/00-env.zsh`

### SSH to network devices shows broken characters

This is a TERM compatibility issue. The `06-tmux.zsh` module should automatically handle this by downgrading TERM for SSH connections to network devices. If issues persist:
- Set `TERM_SAFE=xterm` before SSH
- Ensure hostnames contain keywords like "cisco", "juniper", "switch", or "router" for automatic detection
- Manually set TERM: `TERM=xterm ssh user@device`

### Environment variables not loading

If your environment variables from `.env/` aren't being sourced:
- Check that `.env/` directory exists in the DotMatrix repository root
- Verify files in `.env/` are readable: `ls -la .env/`
- Ensure you're in or below the git repository directory when starting the shell
- The git-root detection in `05-functions.zsh` only works within the DotMatrix git repository

### Zinit plugins not loading

On first run, zinit auto-installs. If plugins aren't working:
- Verify zinit installed: `ls -la ~/.local/share/zinit/`
- Manually trigger installation: `exec zsh`
- Check zinit status: `zinit status`
