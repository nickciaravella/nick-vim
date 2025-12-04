return {
    "folke/snacks.nvim",
    lazy = false,
    keys = {
        {
            "<leader>ff",
            function()
                require("snacks").picker.files()
            end,
        },
        {
            "<leader>fb",
            function()
                require("snacks").picker.buffers()
            end,
        },
        {
            "<leader>fc",
            function()
                require("snacks").picker.command_history()
            end,
        },
        {
            "<leader>gc",
            function()
                require("snacks").picker.git_branches()
            end,
        },
        -- Grep
        {
            "<leader>sb",
            function()
                require("snacks").picker.lines()
            end,
        },
        {
            "<leader>sB",
            function()
                require("snacks").picker.grep_buffers()
            end,
        },
        {
            "<leader>st",
            function()
                require("snacks").picker.grep()
            end,
        },
        {
            "<leader>sw",
            function()
                require("snacks").picker.grep_word()
            end,
            mode = { "n", "x" },
        },
        {
            "<leader>fd",
            function()
                require("snacks").picker.diagnostics()
            end,
        },
        {
            "<leader>fh",
            function()
                require("snacks").picker.help()
            end,
        },
        {
            "<leader>sR",
            function()
                require("snacks").picker.resume()
            end,
        },
        -- LSP
        {
            "gd",
            function()
                require("snacks").picker.lsp_definitions()
            end,
        },
        {
            "gA",
            function()
                require("snacks").picker.lsp_references()
            end,
            nowait = true,
        },
    },
    opts = {
        picker = {
            sources = {
                buffers = {
                    layout = {
                        preset = "select",
                    },
                },
                command_history = {
                    layout = {
                        preset = "select",
                    },
                },
                files = {
                    layout = {
                        preset = "select",
                    },
                },
                git_branches = {
                    layout = {
                        preset = "select",
                    },
                },
                recent = {
                    layout = {
                        preset = "select",
                    },
                },
            },
            layout = {
                preset = "ivy",
            },
            matcher = {
                frecency = true,
            },
            formatters = {
                file = {
                    filename_first = true,
                },
            },
        },
        dashboard = {
            preset = {
                header = [[██████╗ █████╗ ██████╗ ██╗████████╗ █████╗ ██╗      ██████╗ ███████╗
██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝██╔══██╗██║     ██╔═══██╗██╔════╝
██║     ███████║██████╔╝██║   ██║   ███████║██║     ██║   ██║███████╗
██║     ██╔══██║██╔═══╝ ██║   ██║   ██╔══██║██║     ██║   ██║╚════██║
╚██████╗██║  ██║██║     ██║   ██║   ██║  ██║███████╗╚██████╔╝███████║
╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝]]
            },
            sections = {
                { section = "header", padding = 2 },
                {
                    icon = " ",
                    title = "Projects",
                    section = "projects",
                    limit = 6,
                    indent = 2,
                    padding = 1,
                    dirs = {
                        '~/src/theboss/server',
                        '~/src/theboss/client',
                        '~/src/theboss/packages',
                        '~/my/homepage-api',
                        '~/my/homepage-web',
                        '~/.config/nvim'
                    }
                },
                { icon = " ", title = "Recent Files", section = "recent_files", limit = 10, indent = 2, padding = 3 },
                { section = "startup" },
            }
        },
    },
}
