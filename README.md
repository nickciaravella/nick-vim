# nick-vim

Personal Neovim config: Lua, [lazy.nvim](https://github.com/folke/lazy.nvim), Neovim 0.12+, macOS and
Linux.

## Install

```shell
mv "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim-old
git clone git@github.com:nickciaravella/nick-vim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

```shell
./bootstrap.sh
```

`bootstrap.sh` installs the Homebrew-managed system tools below, then runs Neovim headlessly to
sync plugins, compile treesitter parsers, and install Mason's LSP servers, so the first
interactive launch has nothing left to download. It's macOS-only (Homebrew); on Linux, install the
system tools below with your package manager and skip straight to the headless sync at the bottom
of the script. It doesn't install the language toolchains below either — those need to be on
`PATH` first, since lazy.nvim, nvim-treesitter, and Mason only try to install things once and
don't retry if a dependency wasn't there yet. Run `:checkhealth` after.

If something is still broken after installing the missing tool:

- Parsers: `:TSUpdate` recompiles everything.
- LSP servers, formatters, and linters: `:MasonInstall <tool>` retries one.

## Dependencies

### System tools

| Tool | Used for | macOS |
| --- | --- | --- |
| Neovim 0.12+ | `vim._core.ui2`, `vim.lsp.config`, `winborder` | `brew install neovim` |
| git | lazy.nvim bootstrap, gitsigns | preinstalled |
| A Nerd Font | icons in statusline, pickers, explorer | `brew install --cask font-meslo-lg-nerd-font`, then set it as the terminal font |
| ripgrep | grep pickers | `brew install ripgrep` |
| fd | file picker (falls back to `rg`, then `find`) | `brew install fd` |
| tree-sitter CLI 0.26.1+ | nvim-treesitter `main` compiles parsers with it. Install from a package manager, not npm | `brew install tree-sitter-cli` |
| C compiler | Treesitter parser builds | `xcode-select --install` |
| stylua | Lua format on save | `brew install stylua` |

### Language toolchains

Mason installs servers with each language's own package manager, so these need to be on `PATH`
before first launch:

- **Node.js + npm**: ts_ls, eslint, cssls, html, jsonls, yamlls, tailwindcss, prismals, prettierd, cspell
- **Python 3**: jedi_language_server

### Installed through Mason

The LSP servers listed in `lua/plugins/lsp.lua` and the formatters/linters listed in
`lua/plugins/mason-tool-installer.lua` all install automatically.

Mason prepends its bin directory to `PATH` inside Neovim, so conform and nvim-lint pick these up
without a global install. Homebrew versions work too.

| | Filetypes | Tools |
| --- | --- | --- |
| Format on save (conform) | lua | stylua |
| | js / ts / jsx / tsx | prettierd |
| Lint (nvim-lint) | js / ts / jsx / tsx | cspell |

## Layout

```
init.lua              bootstrap lazy.nvim
bootstrap.sh          installs system tools and warms plugin/parser/LSP caches
lua/user/             options, keymaps, autocommands (no plugins)
lua/plugins/          one lazy.nvim spec per plugin
after/lsp/<server>.lua  per-server overrides merged into vim.lsp.config
lazy-lock.json        pinned plugin commits
AGENTS.md             agent instructions; CLAUDE.md symlinks to it
TASKS.md              backlog
```

## Usage

Leader is `<Space>`. Only custom or surprising bindings are listed. mini.ai, mini.surround, and
blink.cmp use their upstream defaults.

### Start page

Starting Neovim without a file opens a snacks.nvim dashboard: the header, the current directory,
and three rows: `f` finds files and `t` greps, the same pickers as `<leader>ff` and `<leader>st`,
and `q` quits. The directory Neovim starts in is the project; there is no project switcher.

### Editing and windows

| Key | Mode | Action |
| --- | --- | --- |
| `jk` / `kj` | insert | Escape |
| `<Esc>` | normal | Clear search highlight if one is active, otherwise plain Esc |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | normal, terminal | Move between windows (also leaves terminal mode) |
| `<S-Up>` `<S-Down>` `<S-Left>` `<S-Right>` | normal | Resize window |
| `<S-h>` / `<S-l>` | normal | Previous / next buffer |
| `<C-p>` | normal | Alternate buffer |
| `<leader><Tab>` | normal | `:b ` prompt |
| `<leader>won` | normal | Close every other buffer |
| `<A-j>` / `<A-k>`, `J` / `K` in visual | normal, visual | Move line(s) up / down |
| `<` / `>` | visual | Indent and stay in visual |
| `p` | visual | Paste without overwriting the register |
| `<leader>ln` | normal | Toggle relative line numbers |
| `<leader>bl` / `<leader>bs` | normal | Toggle indent guides / scope highlight |
| `<CR>` | normal, visual | Treesitter incremental selection (expand to parent node) |
| `N` | visual | Shrink selection to child node |

### Finding (snacks.nvim pickers)

| Key | Picker |
| --- | --- |
| `-` | Explorer at the current file |
| `<leader>ff` / `<leader>fb` / `<leader>fc` | Files / buffers / command history |
| `<leader>fh` / `<leader>fd` | Help tags / diagnostics |
| `<leader>st` / `<leader>sw` | Grep / grep word under cursor or visual selection |
| `<leader>sb` / `<leader>sB` | Lines in current buffer / grep open buffers |
| `<leader>sR` | Resume last picker |
| `<leader>gc` | Git branches |
| `<leader>ao` | Symbol outline (aerial) |

Pickers rank by frecency and show the filename before its path. Files, buffers, git branches, and the
grep pickers open as a VS Code-style dropdown at the top of the screen; command history stays centered.
The grep pickers preview the selected match in the editor window itself and leave it untouched while
the search is empty; Esc restores what was there.

The explorer opens full screen, tree on the left and preview on the right, and closes when you open
a file. `l` / `h` open and close a directory, `<BS>` goes up, `.` re-roots the tree at the directory
under the cursor, `/` filters as you type. `a` adds a file (end with `/` for a directory), `r` renames,
`m` moves, `c` copies, `d` trashes, `<Tab>` selects several files first. `<leader>/` greps the directory
under the cursor; `H` / `I` show hidden and ignored files.

### LSP and diagnostics

- Neovim's builtin maps apply: `grn` rename, `gra` code action, `grr` references, `gri`
  implementation, `gO` document symbols, `K` hover. See `:help lsp-defaults`.
- `gd` definitions and `gA` references open in a snacks picker. `gA` rather than `gr` because `gr`
  is a builtin prefix.
- `[d` / `]d` jump to a diagnostic and open its float.
- `<leader>d` Trouble diagnostics for the workspace, `<leader>D` for the current buffer.
- eslint and tailwindcss do not attach to `.d.ts` files.
- Per-server settings go in `after/lsp/<server>.lua`, not in `lsp.lua`.

### Git

gitsigns only. `]c` / `[c` jump to the next / previous hunk and fall through to diff-mode `]c` in
a diff window. Diffing lives under the `<leader>gd` prefix.

| Key | Action |
| --- | --- |
| `<leader>gdf` | Diff this file against the index in a split |
| `<leader>gda` | Repository diff panel, HEAD against the working tree |
| `<leader>gdt` | Toggle the whole-file inline diff |
| `<leader>gdh` | Preview the hunk under the cursor inline |
| `<leader>gb` | Toggle current-line blame |
| `<leader>gS` | Toggle signs and line-number highlight |

### Treesitter

Text objects: `af` / `if` function, `ac` / `ic` class, `aa` / `ia` parameter. Motions: `]m` / `[m`
function, `]]` / `[[` class, `]a` / `[a` parameter; capital letter jumps to the end. Highlighting and
indent are skipped for CSS, for `.d.ts` files over 2000 lines, and for any file over 20000 lines.

### Behaviors to know about

- Format on save via conform with a 500ms timeout, falling back to LSP formatting. Errors are
  silent; run `:ConformInfo` if formatting stops working.
- Trailing whitespace is stripped on save.
- Completion in markdown and plain text buffers does not offer words from the buffer.
- Comment leaders are not auto-inserted on `o`, `O`, or Enter.
- The command line is a floating window (tiny-cmdline, `cmdheight=0`). Pending operator keys show
  in the statusline instead.
- Terminal buffers open in insert mode.
- Colorscheme is gruvbox hard with a light background.
- `:PopupClose` force-closes the current floating window.
- Node, Python, Ruby, and Perl providers are disabled.
