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
				desc = "Step over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Open debug REPL",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
		},
		config = function()
			-- breakpoint icons
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

	-- DAP UI: auto-opens/closes on debug session
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},

	-- Inline variable values while debugging
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
			enabled = true,
			virt_text_pos = "eol",
		},
	},
}
