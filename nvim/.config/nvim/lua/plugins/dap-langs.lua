return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			-- ==================== PYTHON ====================
			local debugpy_path = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

			dap.adapters.python = {
				type = "executable",
				command = debugpy_path,
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						local cwd = vim.fn.getcwd()
						if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
							return cwd .. "/venv/bin/python"
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						end
						return debugpy_path
					end,
				},
			}

			-- ==================== TYPESCRIPT/JAVASCRIPT ====================
			local js_debug_path =
				vim.fn.expand("~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js")

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_path, "${port}" },
				},
			}

			local ts_config = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**", "node_modules/**" },
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = ts_config
			dap.configurations.javascript = ts_config
			dap.configurations.typescriptreact = ts_config
			dap.configurations.javascriptreact = ts_config
		end,
	},
}
