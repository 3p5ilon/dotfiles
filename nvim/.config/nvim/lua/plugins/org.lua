return {
	{
		"nvim-orgmode/orgmode",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("orgmode").setup({
				-- all .org files in your orgfiles folder
				org_agenda_files = "~/Desktop/orgfiles/**/*",
				-- default file for quick captures
				org_default_notes_file = "~/Desktop/orgfiles/inbox.org",
			})
		end,
	},
}
