return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*",
		dependencies = {
			{
				"folke/snacks.nvim",
				optional = true,
				opts = {
					input = {},
					picker = {
						actions = {
							opencode_send = function(...)
								return require("opencode").snacks_picker_send(...)
							end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = {
										"opencode_send",
										mode = { "n", "i" },
									},
								},
							},
						},
					},
				},
			},
		},
		config = function()
			-- Required for reload events
			vim.o.autoread = true

			-- Global options (customize if needed)
			vim.g.opencode_opts = {}

			-- Ask about current file or selection
			vim.keymap.set({ "n", "x" }, "<leader>oca", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Opencode Ask" })

			-- Select action
			vim.keymap.set({ "n", "x" }, "<leader>ocs", function()
				require("opencode").select()
			end, { desc = "Opencode Select Action" })

			-- Toggle window
			vim.keymap.set({ "n", "t" }, "<leader>ot", function()
				require("opencode").toggle()
			end, { desc = "Opencode Toggle" })

			-- Operator: add motion/range
			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Opencode Add Range" })

			-- Add current line
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Opencode Add Line" })

			-- Scroll session up/down
			vim.keymap.set("n", "<leader>ocu", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Opencode Scroll Up" })

			vim.keymap.set("n", "<leader>ocd", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Opencode Scroll Down" })
		end,
	},
}
