-- Debug adapter configurations for Python, JavaScript/TypeScript, and C/C++
-- Install adapters: :MasonInstall debugpy js-debug-adapter codelldb

return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			-- Python debugging (debugpy)
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

			-- JavaScript/TypeScript debugging (js-debug-adapter)
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

			-- C/C++ debugging (codelldb — requires gcc on system, no llvm needed)
			local codelldb_path =
				vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb")

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					-- auto compile with debug symbols before launching
					program = function()
						local file = vim.fn.expand("%:p")
						local out = vim.fn.expand("%:p:r")
						local result = vim.fn.system("g++ -g -O0 -Wall -std=c++17 " .. file .. " -o " .. out)
						if vim.v.shell_error ~= 0 then
							vim.notify("Compile error:\n" .. result, vim.log.levels.ERROR)
							return nil
						end
						return out
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					terminal = "integrated", -- keeps stdin working for interactive programs
				},
				{
					name = "Launch with args",
					type = "codelldb",
					request = "launch",
					-- useful when your program needs command line arguments
					program = function()
						local file = vim.fn.expand("%:p")
						local out = vim.fn.expand("%:p:r")
						local result = vim.fn.system("g++ -g -O0 -Wall -std=c++17 " .. file .. " -o " .. out)
						if vim.v.shell_error ~= 0 then
							vim.notify("Compile error:\n" .. result, vim.log.levels.ERROR)
							return nil
						end
						return out
					end,
					args = function()
						local args = vim.fn.input("Arguments: ")
						return vim.split(args, " ")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					terminal = "integrated",
				},
			}

			-- C uses same config as C++
			dap.configurations.c = dap.configurations.cpp
		end,
	},
}
