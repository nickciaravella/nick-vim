return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,          -- ts = treesitter
        ts_config = {
            lua = {'string'},     -- it will not add a pair on that treesitter node
            javascript = {'template_string'},
            java = false,         -- don't check treesitter on java (not sure why..)
        },
        disable_filetype = { "TelescopePrompt" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    },
    config = function (_, opts)
        require("nvim-autopairs").setup(opts)
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end
}

