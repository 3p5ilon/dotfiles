return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets", -- snippet collection
		version = "1.*",
		opts = {
			snippets = { preset = "default" },

			keymap = { preset = "default" },

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				menu = {
					draw = {
						-- use treesitter for better highlighting in menu
						treesitter = { "lsp" },
					},
				},
			},

			-- use rust fuzzy matching, fallback to lua if unavailable
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
