local js_based_languages = { "typescript", "typescriptreact", "javascript", "javascriptreact" }

return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
		end,
	},
	{
		-- Debugger that ships with VS Code
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			})

			for _, language in ipairs(js_based_languages) do
				require("dap").configurations[language] = {
					{
						name = "Debug Node Process",
						type = "pwa-node",
						request = "attach",
						processId = function()
							return require("dap.utils").pick_process({ filter = "^node.*server%.js$" })
						end,
						cwd = "${workspaceFolder}",
					},
					{
						name = "---------------\nOthers\n---------------",
						type = "pwa-node",
						request = "attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			require("dapui").setup({})

			dap.listeners.before.attach.dapui_config = function()
				require("dapui").open()
			end
			dap.listeners.before.launch.dapui_config = function()
				require("dapui").open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				require("dapui").close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				require("dapui").close()
			end
		end,
	},
}
