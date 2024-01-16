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
        "windwp/nvim-autopairs",                            -- Automatically created ending for (), {}, etc.
        event = "VeryLazy",
        config = function() require('user/autopairs') end
    },
    {
        "nvim-lualine/lualine.nvim",                        -- Bottom status bar line
        event = "VeryLazy",
        config = function() require('user/lualine') end
    },
    {
        "ahmedkhalf/project.nvim",                          -- Project searching
        config = function() require('user/project') end
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

    -- Color schemes
    { "lunarvim/darkplus.nvim" },                           -- Looks like VS Code

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
    {
        "folke/trouble.nvim" ,                                                  -- Navigating through code issues
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function() require('user/trouble') end
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require('user/telescope') end
    },
    -- requires CMake, but will basically just make fuzzy finding faster.
    -- { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        config = function() require('user/treesitter') end
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim" ,
        event = "VeryLazy",
        config = function() require('user/gitsigns') end
    },

    -- Lanugage helpers
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    }
}

