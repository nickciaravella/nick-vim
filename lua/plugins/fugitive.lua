return {
    "tpope/vim-fugitive",
    dependencies = { 'tpope/vim-rhubarb' },
    lazy = true,
    config = function() require('user/fugitive') end,
    cmd = {
        'G',
        'Git',
        'GBrowse',
    }
}

