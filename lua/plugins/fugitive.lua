return {
    "tpope/vim-fugitive",
    dependencies = { 'tpope/vim-rhubarb' },
    lazy = true,
    cmd = {
        'G',
        'Git',
        'GBrowse',
    },
    keys = {
        { "<leader>gs", ":Git|10wincmd_<CR>", }
    }
}

