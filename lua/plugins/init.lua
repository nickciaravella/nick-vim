return {
    { "dstein64/vim-startuptime" },                           -- Startup profiler
    { "nvim-lua/plenary.nvim" },                              -- Useful lua functions used by lots of plugins
    { "nvim-tree/nvim-web-devicons" },                        -- Icons for file tree and other plugins
    {
        "nvim-tree/nvim-tree.lua",                            --  File tree
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function() require('user/nvim-tree') end
    },
    {
        "lukas-reineke/indent-blankline.nvim",              -- Indentation and whitespace characters
        main = "ibl",
        event = "VeryLazy",
        config = function() require('user/indentline') end
    },
    {
        "goolord/alpha-nvim",                               -- Startup screen
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function() require('user/alpha') end
    },
    {
        "numToStr/Comment.nvim",                            -- Commenting code
        event = "VeryLazy",
        config = function() require('user/comment') end
    },
    {
        "hood/popui.nvim",
        event = "VeryLazy",
        config = function() require "user/popui" end
    },

    -- Auto completions
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
        config = function() require('user/cmp') end
    },
    { "hrsh7th/cmp-buffer", event = "VeryLazy" },
    { "hrsh7th/cmp-path", event = "VeryLazy" },
    { "hrsh7th/cmp-cmdline", event = "VeryLazy" },
    { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
    { 'hrsh7th/cmp-nvim-lsp-signature-help', event = "VeryLazy" },
    { 'saadparwaiz1/cmp_luasnip', event = "VeryLazy" },
    -- More sources can be found here: https://github.com/topics/nvim-cmp

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy"
    },
    {
        "rafamadriz/friendly-snippets",
        event = "VeryLazy"
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function() require('user/lsp/lspconfig') end
    },
    {
        "williamboman/mason.nvim",                                              -- simple to use language server installer
        config = function() require('user/lsp/mason') end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        config = function() require('user/lsp/mason-lspconfig') end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",                                      -- for formatters and linters
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function() require('user/null-ls') end
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy"
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        config = function() require('user/treesitter') end
    },

    -- Lanugage helpers
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    }
}

