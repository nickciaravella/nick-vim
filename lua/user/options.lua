vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

local go_bin = vim.fn.expand("~/go/bin")
if vim.fn.isdirectory(go_bin) == 1 and not string.find(vim.env.PATH or "", go_bin, 1, true) then
	vim.env.PATH = go_bin .. ":" .. (vim.env.PATH or "")
end

local options = {
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 0, -- tiny-cmdline draws the command line in a float
	colorcolumn = "120", -- set a ruler at the 120th column
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	fileencoding = "utf-8", -- the encoding written to a file
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showcmdloc = "statusline", -- cmdheight is 0, so pending operator keys go in the statusline (%S)
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	tabstop = 4, -- insert 4 spaces for a tab
	number = true, -- set numbered lines
	statuscolumn = "%s %l    ", -- creating space between the line numbers and code

	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	linebreak = true, -- companion to wrap, don't split words
	scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
	sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
	guifont = "monospace:h17", -- the font used in graphical neovim applications
	whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line

	listchars = { space = "·" }, -- shown by `:set list`
	winborder = "rounded", -- options are none, single, double, rounded, solid, shadow
}
for k, v in pairs(options) do
	vim.opt[k] = v
end

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.diffopt:remove("linematch:40") -- default entry; replaced by the larger budget below
vim.opt.diffopt:append("linematch:60") -- improve native diff alignment for reviewing external edits
