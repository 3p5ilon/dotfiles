return {
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- Skip pairing if the next character is alphanumeric or punctuation (e.g., word_name)
			skip_next = [=[[%w%%%\'%[%\"%.%`%$]]=],
			-- Skip pairing when cursor is inside a TreeSitter string
			skip_ts = { "string" },
			-- Prevents adding extra closing brackets if a pair is already closed
			skip_unbalanced = true,
			-- Smart handling for Markdown triple backticks (```)
			markdown = true,
		},
	},
}
