return {
    'github/copilot.vim',
    event = 'BufRead',
    config = function ()
        vim.g.copilot_assume_mapped = true
    end
}
