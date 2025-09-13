# Neovim

## System Dependencies

This Neovim configuration requires the following system dependencies:

- **Node.js**: Required for TypeScript/JavaScript LSP (vtsls), ESLint, CSS LSP, HTML LSP, and GitHub Copilot integration.
- **Rust**: Optional, Only required for Rust LSP (rust_analyzer) and the fuzzy matcher in blink.cmp.
- **Go**: Optional, Only required for Go LSP (gopls).
- **ripgrep (rg)**: Used by Telescope for live grep functionality.
- **fd**: Optional, Used by Telescope for faster file finding (alternative and will fall-back to `find`).
- **make**: Required to build telescope-fzf-native for improved performance.
- **git**: Required for Git integration plugins (vim-fugitive, gitsigns).
- **tmux**: Optional, required only for tmux integration when running inside tmux.

## Plugins

The configuration uses lazy.nvim as the plugin manager and includes the following plugins:

### Core Plugins
- **lazy.nvim**: Plugin manager for Neovim.
- **nvim-treesitter**: Syntax highlighting, incremental selection, and textobjects. Includes nvim-treesitter-textobjects and nvim-treesitter-context for enhanced navigation.
- **mason.nvim** and **mason-lspconfig**: LSP server installer and bridge to nvim-lspconfig.
- **nvim-lspconfig**: Configuration for LSP servers, with custom configs for:
  - vtsls (TypeScript/JavaScript/Vue)
  - eslint
  - gopls (Go)
  - html
  - cssls
  - lua_ls
  - rust_analyzer

### Completion and Snippets
- **blink.cmp**: Fast completion engine with fuzzy matching, integrated with Copilot.
- **friendly-snippets**: Snippet collection.
- **blink-copilot**: Copilot integration for blink.cmp.

### Search and Navigation
- **telescope.nvim**: Fuzzy finder with fzf-native extension for improved performance. Includes keymaps for files, grep, diagnostics, and more.
- **which-key.nvim**: Displays available keybindings.

### Git Integration
- **vim-fugitive**: Git commands and status.
- **gitsigns.nvim**: Git signs and hunk previews.

### Debugging
- **mason-nvim-dap**: DAP (Debug Adapter Protocol) installer.
- **nvim-dap** and **nvim-dap-ui**: Debugging support with UI, configured for Go.

### Utilities
- **Comment.nvim**: Easy commenting with `gcc` and `gc`.
- **copilot.lua**: GitHub Copilot integration.
- **firenvim**: Browser integration for text areas.
- **tmux.nvim**: Seamless tmux integration when running inside tmux.
- **fluoromachine.nvim**: Color scheme with transparent background.

## Notable Changes and Customizations

### Leader Key
- Leader key set to `<Space>`.

### Settings
- Relative line numbers enabled.
- True color support enabled.
- Search highlighting enabled.
- Command line hidden.
- Backup and write backup disabled.
- Persistent undo enabled with custom directory.
- Auto-read files on external changes.
- Whitespace characters displayed (spaces as `·`, tabs as `→ `, EOL as `↴`).
- Mouse disabled.
- Swap file disabled.
- Scrolloff set to 999 for cursor centering.
- Line wrapping disabled.
- Netrw banner removed.

### Keymaps
- **Window resizing**: `<M-h/j/k/l>` to resize windows by 5 units.
- **Git**: `<S-l>` to preview hunk inline.
- **Visual mode**: `J/K` to move lines up/down.
- **Diagnostics**: `<S-h>` to open floating diagnostics.
- **Quickfix**: `<S-q>` to open quickfix list.
- **LSP**: `<F4>` for code actions, `<F2>` for rename, `<F3>` for format.
- **Telescope**: Various `<leader>` prefixed keymaps for searching files, grep, diagnostics, etc.
- **Debugging**: `<F5>` to continue, `<F49-51>` for stepping, `<leader>b` for breakpoints.

### Custom Commands
- **Tree**: Opens netrw in a vertical split for module-specific directories (matches patterns like `app/design/`, `app/code/`, or capitalized paths).

### Theme
- Fluoromachine theme with transparent background and black status line.

### LSP Configurations
- Automatic filetype aliases (zsh/dosbatch to bash).
- Custom settings for vtsls with Vue support if vue-language-server is installed.

### DAP Configurations
- Go debugging with Delve adapter, including remote attach and custom args.
