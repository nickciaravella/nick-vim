#!/usr/bin/env bash
# Installs this config's system dependencies via Homebrew, then installs plugins,
# treesitter parsers, and Mason LSP servers headlessly so the first interactive
# launch has nothing left to download. Run once after cloning the repo.
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
	echo "Homebrew not found. Install it from https://brew.sh, then re-run this script." >&2
	exit 1
fi

echo "Installing system tools..."
brew install neovim ripgrep fd tree-sitter-cli stylua
brew install --cask font-meslo-lg-nerd-font

if ! xcode-select -p >/dev/null 2>&1; then
	echo "No C compiler found. Run 'xcode-select --install' to get one (needed for treesitter parser builds), then re-run this script." >&2
	exit 1
fi

echo "Syncing plugins..."
nvim --headless "+Lazy! sync" +qa

echo "Waiting for treesitter parsers and Mason servers to finish installing..."
nvim --headless -c "lua
  local function settle(get_count, timeout, quiet_for)
    local last, stable_since = -1, vim.uv.now()
    vim.wait(timeout, function()
      local n = get_count()
      if n ~= last then
        last = n
        stable_since = vim.uv.now()
      end
      return (vim.uv.now() - stable_since) > quiet_for
    end, 250)
  end
  settle(function() return #require('nvim-treesitter.config').get_installed() end, 300000, 2000)
  settle(function() return #require('mason-registry').get_installed_package_names() end, 300000, 2000)
" +qa

echo "Done. Node/Python toolchains from the README still need a manual install."
