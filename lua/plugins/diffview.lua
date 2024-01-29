return {
    'sindrets/diffview.nvim',
    opts = {
        view = {
            default = {
                layout = "diff1_plain",
                winbar_info = false,
            }
        }
    },
    keys = {
        { '<leader>tv', '<cmd>DiffviewOpen<cr>' },
        { '<leader>tc', '<cmd>DiffviewClose<cr>' },
    },
}
