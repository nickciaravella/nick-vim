return {
    'ThePrimeagen/harpoon',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
    },
    keys = {
        { 'mg', function () require('harpoon.mark').add_file() end },
        { 'mu', function () require("harpoon.ui").toggle_quick_menu() end },
        { 'ma', function () require('harpoon.ui').nav_file(1) end },
        { 'ms', function () require('harpoon.ui').nav_file(2) end },
        { 'md', function () require('harpoon.ui').nav_file(3) end },
        { 'mf', function () require('harpoon.ui').nav_file(4) end },
    }
}
