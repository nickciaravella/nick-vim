return {
    "lukas-reineke/indent-blankline.nvim",              -- Indentation and whitespace characters
    main = "ibl",
    event = "BufRead",
    opts = {
        indent = { char = "▏" },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
            -- injected_languages = false,
            -- highlight = { "Function", "Label" },
            -- priority = 500,
        }
    }
}
