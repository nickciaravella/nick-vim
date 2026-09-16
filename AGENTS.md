# Agent instructions

Personal Neovim config: Lua, lazy.nvim, Neovim 0.12+, macOS and Linux (Omarchy). `README.md`
covers setup, layout, and the custom keymaps; read it before making changes. `TASKS.md` is the
backlog.

## Rules

### 1. Check for newer plugin versions before changing plugin config

Whenever you touch a spec in `lua/plugins/`, first find out whether the plugin has moved on from
the commit pinned in `lazy-lock.json`:

```shell
git -C ~/.local/share/nvim/lazy/<plugin> fetch --quiet
git -C ~/.local/share/nvim/lazy/<plugin> log --oneline HEAD..origin/<branch>
```

Then read the upstream README or changelog at HEAD for renamed or deprecated options, new
defaults, and new features that cover something this config does by hand.

Take the update in a non-breaking way:

- Keep current behavior. Migrate deprecated options instead of pinning an older commit to avoid them.
- Layer our config on top of the new defaults. If upstream now does something we implemented
  ourselves, use theirs and delete ours.
- Do not restate values that match upstream defaults.
- Update `lazy-lock.json` with `:Lazy update <plugin>` (or
  `nvim --headless "+Lazy! update <plugin>" +qa`) and commit it in the same commit as the config
  change.
- Plugins with `version = "*"` or `"1.*"` track releases; nvim-treesitter and
  nvim-treesitter-textobjects track `main`. Call out major version bumps explicitly.

### 2. Flag overlaps between Neovim builtins and plugins

When a plugin update or a config change makes two things do the same job, say so explicitly in
your summary. Default to the Neovim builtin when it is equivalent for how this config actually uses
the feature, and remove the plugin, option, or keymap that duplicates it. If the plugin does
something extra that we rely on, keep it and say what.

The same applies between plugins, for example snacks.nvim against a standalone plugin covering the
same feature.

Precedent in this repo: builtin `gc` replaced mini.comment, `vim.lsp.config` root_dir replaced a
custom LspAttach detach hook, `vim.treesitter._select` provides incremental selection,
`vim.diagnostic.config({ jump = ... })` opens the float after `]d`, and `<Esc>` clears search
highlight without a plugin.

### 3. Keep the docs current

- `README.md`: update when adding or removing a plugin, changing a keymap listed there, or adding
  an external dependency (system tool, Mason package, language toolchain).
- `AGENTS.md`: update when a convention or workflow in this file changes.
- Docs describe the current state only. No changelogs, no "recently added" notes.

### 4. Propose new plugins, never add them

If a task would benefit from a plugin that is not installed, describe it and why in your summary
and stop there. Before proposing, check whether a Neovim builtin or an unused snacks.nvim or
mini.nvim module already covers it.

### 5. Private Neovim APIs are allowed, but flag every use

`vim._core.ui2` and `vim.treesitter._select` are used because no public equivalent exists. New
uses of `vim._*` modules are fine on the same basis, but call each one out in your summary: they
can break on any Neovim upgrade. When a public replacement lands, switch to it.

## TASKS.md

- Plain bullet list of confirmed work.
- Add an item only when the user asks for it, or when you suggested it in a summary and they
  confirmed. Suggestions go in the summary first, not the file.
- Never check items off. Delete the item in the same commit that completes it.

## Conventions

- macOS and Linux only. Unix paths and Homebrew or pacman assumptions are fine. Nothing for Windows.
- One lazy.nvim spec per file in `lua/plugins/`. Prefer `opts` over `config` unless setup needs
  surrounding code.
- Lazy-load where safe. When adding or touching a plugin, give it `event`, `cmd`, `ft`, or `keys`
  unless it must run at startup (colorscheme, UI that draws immediately). Use the triggers the
  plugin documents rather than guessing.
- Per-server LSP settings live in `after/lsp/<server>.lua`, not in `lua/plugins/lsp.lua`.
- Formatting is stylua with default settings (tabs).
- Comments only where the reason is not obvious from the code. This includes
  `lua/user/options.lua`: when touching it, trim per-option comments that restate the option name.
- Do not extend `lua/user/vsc/`. It is slated for removal; see `TASKS.md`.

## Verifying changes

There are no tests. The smoke check after any change:

```shell
nvim --headless "+lua print('ok')" +qa
```

must print `ok` with nothing else on stderr, and `stylua --check` must pass on every touched file.

For anything beyond a trivial edit, verify behavior headless instead of by reading code. Put the
probe in a Lua file and run `nvim --headless --cmd "luafile trace.lua" -c "luafile probe.lua" -c "qa!"`.

- `trace.lua` runs before `init.lua` and wraps `vim.deprecate` and `vim.notify` (WARN and above) to
  append to a log file, so deprecations and warnings from startup and plugin load are captured.
- Load every spec so lazy-loaded `config` functions run:
  `require("lazy").load({ plugins = vim.tbl_keys(require("lazy.core.config").plugins) })`.
- Drive keymaps with `vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "x", false)`;
  `<leader>` is a literal space. Read results through the API: cursor position, `vim.fn.mode()`,
  extmarks, window and tabpage counts, `vim.fn.maparg(lhs, mode, false, true)`.
- Wait for async work with `vim.wait(ms, predicate)`: LSP attach via `vim.lsp.get_clients({ bufnr = 0 })`,
  gitsigns via a non-empty `require("gitsigns").get_hunks(0)` before any diff action, lualine via
  `require("lualine").refresh()` followed by `vim.api.nvim_eval_statusline`.
- LSP checks need a fixture project in a temp directory (`package.json`, `tsconfig.json`, eslint and
  tailwind configs, a `.ts` and a `.d.ts`). Git checks need a throwaway repo with a committed file
  that has since been modified.
- Capture `:checkhealth` with `:checkhealth` followed by `:w! <file>`.

Headless caveats:

- Anything set up on `UIEnter` never runs (snacks input and select, the dashboard), so health errors
  about them are artifacts.
- `nvim_win_set_cursor` does not fire `CursorMoved`; use `:doautocmd` when a plugin depends on it.
- Neovim accepts at most ten `-c` arguments; keep probes in files.
- stderr and stdout interleave; redirect stderr to a file before filtering output.
