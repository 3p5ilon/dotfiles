return {
	-- Core DAP client
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "REPL",
			},
		},
		config = function()
			-- Make breakpoints visible with icons
			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DiagnosticError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "",
				texthl = "DiagnosticWarn",
				linehl = "Visual",
				numhl = "DiagnosticWarn",
			})
		end,
	},

	-- UI for debugging
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dapui = require("dapui")
			dapui.setup()

			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},

	-- Inline variable values
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
			enabled = true,
			virt_text_pos = "eol",
		},
	},
}
