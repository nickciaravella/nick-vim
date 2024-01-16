return {
    'kristijanhusak/vim-dadbod-ui',
    lazy = true,
    dependencies = {
        { 'tpope/vim-dadbod' },
        { 'kristijanhusak/vim-dadbod-completion' },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
    end,
}

