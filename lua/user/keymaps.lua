local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>won", ":%bd|e#|bd#<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Code actions & trouble
keymap("n", "<leader>tt", function() require("trouble").toggle() end)
keymap("n", "gf", ":lua vim.lsp.buf.code_action()<CR>")

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Hold onto pasted line
keymap("v", "p", '"_dP', opts)

-- Telescope
vim.keymap.set('n', '<leader>fr', function () require('telescope.builtin').oldfiles() end, { desc = '[F]ind [R]ecently opened files' })
vim.keymap.set('n', '<leader>fb', function () require('telescope.builtin').buffers() end, { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>sc', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find({previewer = false })
end, { desc = '[S]earch in [C]urrent buffer' })
vim.keymap.set('n', '<leader>ff', function () require('telescope.builtin').find_files() end, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', function () require('telescope.builtin').git_files() end, { desc = '[F]ind [G]it files' })
vim.keymap.set('n', '<leader>sh', function () require('telescope.builtin').help_tags() end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', function () require('telescope.builtin').grep_string() end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function () require('telescope.builtin').live_grep() end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sr', function () require('telescope.builtin').resume() end, { desc = '[S]earch [R]esume' })

-- LSP mappings
vim.keymap.set('n', '<leader>gd', function () require('telescope.builtin').lsp_definitions() end, { desc = '[G]o to [D]efinition' })
vim.keymap.set('n', '<leader>gr', function () require('telescope.builtin').lsp_references() end, { desc = '[G]o to [R]eferences' })
vim.keymap.set('n', '<leader>gs', function () require('telescope.builtin').lsp_document_symbols() end, { desc = '[G]o to [S]ymbols' })
vim.keymap.set('n', '<leader>gi', function () require('telescope.builtin').lsp_implementations() end, { desc = '[G]o to [I]mplementations' })
vim.keymap.set('n', '<leader>gt', function () require('telescope.builtin').lsp_type_definitions() end, { desc = '[G]o to [T]ype Defintion' })
vim.keymap.set('n', '<S-k>', "<CMD>lua vim.lsp.buf.hover()<CR>")

-- Diagnostics
vim.keymap.set('n', '<leader>dl', function () require('telescope.builtin').diagnostics() end, { desc = '[D]iagnostics [L]ist' })
vim.keymap.set('n', '<leader>dk', "<CMD>lua vim.lsp.diagnostics.goto_prev()<CR>", { desc = '[D]iagnostics - Previous' })
vim.keymap.set('n', '<leader>dj', "<CMD>lua vim.lsp.diagnostics.goto_next()<CR>", { desc = '[D]iagnostics - Next' })
vim.keymap.set('n', '<leader>ds', "<CMD>lua vim.lsp.diagnostics.open_float()<CR>", { desc = '[D]iagnostics - [S]how' })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- NVimTree --
keymap("n", "<C-e>", ":NvimTreeToggle<CR>", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
