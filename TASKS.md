# Tasks

Backlog of confirmed work. Remove an item when it lands; never check it off. Rules for editing this
file are in `AGENTS.md`.

- Remove all VS Code related config: `lua/user/vsc/`, the `vim.g.vscode` branch in `init.lua`, and
  the VS Code section of `README.md`.
- Drop Windows support: remove the Windows install steps and the Windows GCC note from `README.md`.
  No Windows-only Lua config exists.
- Decide on a file tree or other way to view files
- Decide on a startup page or other dashboard
- Remove "Buffer" sources for autocomplete for markdown buffers
- Do an audit against LazyVim and other distros to see if there are features worth taking in
