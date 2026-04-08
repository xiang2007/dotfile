# Neovim Configuration Reference

This documentation outlines the plugins, keybindings, and editor settings for this Neovim environment. The configuration is built on **Lazy.nvim** and uses the **Oxocarbon** colorscheme.

`<leader>` is the **Space** key.

---

## Core UI and Aesthetics
* **Colorscheme**: Oxocarbon (High-contrast IBM Carbon palette).
* **Tabline**: Barbar.nvim (Buffer management with mouse support).
* **Statusline**: Lualine.nvim (Bottom information bar styled for Oxocarbon).
* **Dashboard**: Alpha-nvim (Fast, minimal greeter).
* **Motion**: Luxmotion (Instant character jumping).
* **Guides**: Indent-Blankline (Vertical indentation markers).

---

## Keybindings

### Navigation and Motion
| Key | Action | Plugin |
| :--- | :--- | :--- |
| `s` | Jump to character on screen | Luxmotion |
| `Alt + .` | Switch to next buffer | Barbar |
| `Alt + ,` | Switch to previous buffer | Barbar |
| `Alt + >` | Move current buffer right | Barbar |
| `Alt + <` | Move current buffer left | Barbar |
| `<leader>x` | Close current buffer | Barbar |
| `<leader>pf` | Search files by name | Telescope |
| `<leader>ps` | Search text within files (grep) | Telescope |

### Editing and Logic
| Key | Action | Plugin |
| :--- | :--- | :--- |
| `u` | Undo with visual glow | Undo-Glow |
| `U` | Redo with visual glow | Undo-Glow |
| `p / P` | Paste with visual glow | Undo-Glow |
| `gcc` | Toggle line comment | native/Comment |
| `gd` | Go to definition | LSP |
| `K` | View documentation hover | LSP |
| `Ctrl + Space` | Trigger completion menu | nvim-cmp |

### Git and Search
| Key | Action | Plugin |
| :--- | :--- | :--- |
| `]c` | Jump to next git change | Gitsigns |
| `[c` | Jump to previous git change | Gitsigns |
| `<leader>hp` | Preview git hunk changes | Gitsigns |
| `n / N` | Next/Previous search result | hlslens |
| `*` | Search word under cursor | hlslens |

### Nvim sturcture
.
├── init.lua                # The "Brain" (starts the boot sequence)
├── install.sh              # Portable script to set up on other machines
├── lazy-lock.json          # Keeps your plugin versions consistent
└── lua/
    └── wee/
        ├── init.lua        # Entry point for the 'wee' namespace
        ├── set.lua         # Core editor settings (tabs, numbers, etc.)
        ├── lazy_init.lua   # Lazy.nvim setup and performance tweaks
        └── lazy/           # Modular plugin folder
            ├── lsp.lua     # Language server configuration
            ├── telescope.lua
            └── ...         # (All other 18+ plugin files)
