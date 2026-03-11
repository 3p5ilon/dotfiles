return {
	{
		"nvim-orgmode/orgmode",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("orgmode").setup({
				org_agenda_files = "~/Documents/orgfiles/**/*",
				org_default_notes_file = "~/Documents/orgfiles/notes.org",
			})

			-- Archive DONE tasks from todo.org to archive.org with date heading
			vim.api.nvim_create_user_command("OrgArchive", function()
				local buf = vim.api.nvim_get_current_buf()
				local path = vim.api.nvim_buf_get_name(buf)

				-- Only run in todo.org
				if not path:match("todo.org$") then
					print("❌ Open todo.org first")
					return
				end

				-- Get all lines from current buffer
				local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
				local done_lines = {} -- Store DONE tasks
				local done_indices = {} -- Store their line numbers

				-- Find all completed tasks (format: "** DONE")
				for i, line in ipairs(lines) do
					if line:match("^%*%* DONE") then
						table.insert(done_lines, line)
						table.insert(done_indices, i)
					end
				end

				if #done_lines == 0 then
					print("📝 No DONE tasks found")
					return
				end

				-- Remove DONE tasks from todo.org (iterate backwards to preserve indices)
				for i = #done_indices, 1, -1 do
					table.remove(lines, done_indices[i])
				end
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

				-- Format today's date as "* 2024-01-15 Tuesday"
				local date = os.date("*t")
				local date_header = string.format("* %d-%02d-%02d %s", date.year, date.month, date.day, os.date("%A"))

				-- Append tasks to archive.org
				local archive_path = vim.fn.expand("~/Documents/orgfiles/archive.org")
				local archive = io.open(archive_path, "a")
				if archive then
					archive:write("\n" .. date_header .. "\n")
					for _, line in ipairs(done_lines) do
						archive:write(line .. "\n")
					end
					archive:close()
					print(string.format("✅ Archived %d task(s) to archive.org", #done_lines))
				else
					print("❌ Failed to open archive.org")
				end
			end, {})
		end,
	},
}
