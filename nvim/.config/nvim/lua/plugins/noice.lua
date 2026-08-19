return {
	"folke/noice.nvim",
	enabled = false,
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true, -- Clean search prompt
			command_palette = true, -- Centered cmdline popup
			long_message_to_split = true, -- Send long output to a split
		},
	},
}
