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
        { "<leader>ts", ":Git|10wincmd_<CR>", }
    }
}

