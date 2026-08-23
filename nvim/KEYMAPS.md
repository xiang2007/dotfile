# Neovim Controls

Everything in this setup, in one place. Your leader key is **Space** — press it and
wait a moment to see which-key pop up with the available prefixes.

> Tip: `Space sk` searches *all* keymaps, so you can find any binding without
> remembering it. `:help` is always there too.

## Finding things (files, text, symbols)

| Key | What it does |
|---|---|
| `Space ff` / `Ctrl+P` | Find files (fuzzy) |
| `Space fg` / `Ctrl+Shift+F` | Search text across the whole project |
| `Space fb` | Jump between open buffers |
| `Space fr` | Recently opened files |
| `Space fh` | Search Neovim help |
| `Space sf` | Find files (kickstart-style alias) |
| `Space sg` | Grep the project (alias) |
| `Space ss` | List every Telescope picker |
| `Space sd` | List diagnostics |
| `Space sw` | Grep for the word under the cursor |
| `Space sc` | Search commands |
| `Space sn` | Search your Neovim config files |
| `Space sr` | Re-open the last picker |
| `Space s.` | Recent files |
| `Space s/` | Grep only in open files |
| `Space /` | Fuzzy-search inside the current buffer |
| `Ctrl+Shift+P` | Pick any Telescope action |
| `Ctrl+Shift+E` / `\` | Toggle the file explorer (neo-tree) |
| `Space o` | Open file browser (oil) — navigate like a buffer |
| `Space Space` | Buffer picker |

> Xfce4-terminal uses `Ctrl+Shift+F` for its own Find dialog — if that key gets
> swallowed, use `Space fg` instead.

### oil.nvim quick controls

| Key | What it does |
|---|---|
| `Enter` | Open the file / enter the directory |
| `-` | Go up one directory |
| `~` | Go to your home directory |
| `?` | Show oil's help |
| `q` | Close the browser |

## LSP (intelligent code features)

Works once a language server attaches — open a `.c`, `.cpp`, `.h`, or `.py` file.

| Key | What it does |
|---|---|
| `F12` / `grd` | Go to definition |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `grD` | Go to declaration |
| `F2` / `grn` | Rename symbol |
| `gra` | Code actions (fix suggestions) |
| `K` | Hover: docs for the thing under the cursor |
| `gO` | Symbols in this file |
| `gW` | Symbols in the whole project |
| `[d` / `]d` | Previous / next diagnostic |
| `Space q` | Send all diagnostics to the quickfix list |
| `Space th` | Toggle inlay hints (e.g. inferred types) |

## Git

| Key | What it does |
|---|---|
| `]c` / `[c` | Next / previous git hunk |
| `Space hs` | Stage hunk |
| `Space hr` | Reset hunk |
| `Space hS` | Stage whole buffer |
| `Space hR` | Reset whole buffer |
| `Space hp` | Preview hunk |
| `Space hi` | Preview hunk inline |
| `Space hb` | Blame current line |
| `Space hd` | Diff against the index |
| `Space hD` | Diff against last commit |
| `Space hQ` | All repo changes → quickfix |
| `Space hq` | Changes in this file → quickfix |
| `Space tb` | Toggle line blame |
| `Space tw` | Toggle intra-line word diff |
| `ih` | Select a hunk (operator/visual) |

## Editing niceties

| Key | What it does |
|---|---|
| `Space w` / `Ctrl+S` | Save |
| `Space f` | Format buffer (`Space f` = one press; `Space ff` = two) |
| `gcc` / `gc` / `Ctrl+/` | Toggle line / selection comment |
| `sa` `<motion>` `<char>` | Surround: e.g. `saiw"` wraps word in quotes |
| `sd` `<char>` | Delete surround: e.g. `sd"` |
| `sr` `<old><new>` | Replace surround: e.g. `sr"'` |
| `a` / `i` + char | Around / inside text objects: `a)`, `iw`, `i"` |
| `aa` / `ii` | Same, but extending to the next occurrence |
| `]q` / `[q` | Next / previous quickfix item |
| `Space ur` | Toggle relative line numbers |

Autopairs are on — brackets and quotes close themselves as you type.

## Completion menu (blink.cmp)

| Key | What it does |
|---|---|
| `Ctrl+Space` | Open completion / docs |
| `Ctrl+N` / `Ctrl+P` | Next / previous item |
| `Ctrl+Y` | Accept the suggestion |
| `Ctrl+E` | Hide the menu |
| `Ctrl+K` | Toggle signature help |
| `Tab` / `Shift+Tab` | Navigate snippet placeholders |

## Windows & terminal

| Key | What it does |
|---|---|
| `Ctrl+H/J/K/L` | Move focus between splits |
| `:vsp` / `:sp` | Split vertically / horizontally |
| `Esc Esc` | Leave terminal mode (or `Ctrl+\ Ctrl+N`) |

## Vim basics (if new to vim)

| Key | What it does |
|---|---|
| `i` / `a` | Insert before / after cursor |
| `Esc` | Back to normal mode |
| `h j k l` | Move left / down / up / right |
| `w` / `b` | Jump word forward / backward |
| `u` / `Ctrl+R` | Undo / redo |
| `yy` / `p` | Copy line / paste |
| `dd` | Delete line |
| `/` `?` | Search forward / backward, `n` / `N` to repeat |
| `Space` `Space` then pick | Switch buffer |
| `:w` / `:q` | Save / quit (`:wq` both) |

## Managing the setup

- `:Mason` — install/update language servers and tools
- `:lua vim.pack.update()` — update all plugins
- `:checkhealth` — diagnose problems
- `Space sk` — browse every keymap
