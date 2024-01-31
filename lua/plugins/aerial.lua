return {
    'stevearc/aerial.nvim',
    opts = {
        autojump = true,
        float = {
            relative = "editor",
        }
    },
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        { '<leader>ao', '<CMD>AerialToggle<CR>' }
    }
}
