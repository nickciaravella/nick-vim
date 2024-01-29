return {
    "lunarvim/darkplus.nvim",
    config = function()
        local colorscheme = "darkplus"
        vim.cmd("colorscheme " .. colorscheme)
    end
}
