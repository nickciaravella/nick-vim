return {
    {
        "lunarvim/darkplus.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            -- local colorscheme = "darkplus"
            -- vim.cmd("colorscheme " .. colorscheme)
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local colorscheme = "tokyonight-night"
            vim.cmd("colorscheme " .. colorscheme)
        end,
    }
}
