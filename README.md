# Neovim

Custom Neovim configuration with extensive plugin ecosystem for efficient text editing and development.

## Plugins

### Core Plugins
- **lazy.nvim**: Plugin manager
- **nvim-treesitter**: Syntax highlighting, incremental selection, textobjects
- **mason.nvim** and **mason-lspconfig**: LSP server installer
- **nvim-lspconfig**: LSP server configurations for vtsls, eslint, gopls, html, cssls, lua_ls, rust_analyzer

### Completion and Snippets
- **blink.cmp**: Fast completion engine with Copilot integration
- **friendly-snippets**: Snippet collection
- **blink-copilot**: Copilot integration

### Search and Navigation
- **telescope.nvim**: Fuzzy finder with fzf-native extension
- **which-key.nvim**: Keybinding display

### Git Integration
- **vim-fugitive**: Git commands and status
- **gitsigns.nvim**: Git signs and hunk previews

### Debugging
- **mason-nvim-dap**: DAP installer
- **nvim-dap** and **nvim-dap-ui**: Debugging support with UI

### Utilities
- **Comment.nvim**: Easy commenting
- **copilot.lua**: GitHub Copilot
- **firenvim**: Browser integration
- **tmux.nvim**: Tmux integration
- **fluoromachine.nvim**: Color scheme

## Integrations

- **tmux**: Seamless pane navigation
- **Git**: Full git workflow support
- **GitHub Copilot**: AI-powered code completion
- **LSP**: Language server support for multiple languages
- **DAP**: Debugging capabilities

## Configuration

### Leader Key
- Leader key set to `<Space>`

### Settings
- Relative line numbers enabled
- True color support enabled
- Search highlighting enabled
- Command line hidden
- Backup and write backup disabled
- Persistent undo enabled
- Auto-read files on external changes
- Whitespace characters displayed
- Mouse disabled
- Swap file disabled
- Scrolloff set to 999 for cursor centering
- Line wrapping disabled
- Netrw banner removed

### Keymaps
- Window resizing: `<M-h/j/k/l>`
- Git: `<S-l>` for hunk preview
- Visual mode: `J/K` to move lines
- Diagnostics: `<S-h>` for floating diagnostics
- Quickfix: `<S-q>` for quickfix list
- LSP: `<F4>` code actions, `<F2>` rename, `<F3>` format
- Telescope: Various `<leader>` keymaps for search
- Debugging: `<F5>` continue, `<F49-51>` stepping, `<leader>b` breakpoints

### Custom Commands
- **Tree**: Opens netrw for module-specific directories

### Theme
- Fluoromachine theme with transparent background

### LSP Configurations
- Automatic filetype aliases
- Custom settings for vtsls with Vue support

### DAP Configurations
- Go debugging with Delve adapter

## System Dependencies

### Required

- **neovim** - Text editor
- **nodejs** - Required for LSP servers (TypeScript/JavaScript/Vue), ESLint, CSS/HTML LSP, and GitHub Copilot
- **ripgrep (rg)** - Required for Telescope live grep functionality
- **make** - Required to build telescope-fzf-native plugin
- **git** - Required for git integration plugins

### Optional

- **Rust** - Required for Rust LSP (rust_analyzer) and fuzzy matching in blink.cmp
- **Go** - Required for Go LSP (gopls)
- **fd** - Faster file finding for Telescope (falls back to `find`)
- **tmux** - Required for tmux integration

## Installation

1. Install neovim and required dependencies
2. Clone this configuration to `~/.config/nvim/`
3. Run `:Lazy sync` in neovim to install plugins
4. Restart neovim to apply changes
