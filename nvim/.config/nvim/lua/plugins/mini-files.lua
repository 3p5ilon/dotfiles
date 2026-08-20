return {
	"echasnovski/mini.files",
	version = false,
	keys = {
		{
			"<leader>e",
			function()
				local mf = require("mini.files")
				if not mf.close() then
					local buf = vim.api.nvim_buf_get_name(0)
					local path = vim.fn.filereadable(buf) == 1 and buf or vim.uv.cwd()
					mf.open(path, true)
				end
			end,
			desc = "Toggle mini.files",
		},
	},
	opts = {
		mappings = {
			go_in = "L",
			go_in_plus = "l",
		},
		-- windows = {
		-- 	preview = true,
		-- 	width_focus = 30,
		-- 	width_preview = 45,
		-- },
		options = {
			use_as_default_explorer = true,
		},
	},
	config = function(_, opts)
		local mf = require("mini.files")
		mf.setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				vim.api.nvim_win_set_config(args.data.win_id, { border = "rounded" })
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local b = args.data.buf_id

				-- Enter key: Opens file & closes window, or steps into directory
				vim.keymap.set("n", "<CR>", function()
					local entry = mf.get_fs_entry()
					local is_file = entry and entry.fs_type == "file"
					mf.go_in({ close = is_file })
				end, { buffer = b, desc = "Open file or enter dir" })

				-- Vertical split
				vim.keymap.set("n", "<C-v>", function()
					local entry = mf.get_fs_entry()
					if entry and entry.fs_type == "file" then
						mf.close()
						vim.cmd.vsplit(entry.path)
					end
				end, { buffer = b, desc = "Open in vsplit" })

				-- Horizontal split
				vim.keymap.set("n", "<C-s>", function()
					local entry = mf.get_fs_entry()
					if entry and entry.fs_type == "file" then
						mf.close()
						vim.cmd.split(entry.path)
					end
				end, { buffer = b, desc = "Open in split" })

				-- Copy absolute path
				vim.keymap.set("n", "yp", function()
					local entry = mf.get_fs_entry()
					if entry then
						vim.fn.setreg("+", entry.path, "c")
						vim.notify("Copied path: " .. entry.path, vim.log.levels.INFO)
					end
				end, { buffer = b, desc = "Copy absolute path" })

				-- Copy relative path
				vim.keymap.set("n", "yr", function()
					local entry = mf.get_fs_entry()
					if entry then
						local rel = vim.fn.fnamemodify(entry.path, ":.")
						vim.fn.setreg("+", rel, "c")
						vim.notify("Copied relative path: " .. rel, vim.log.levels.INFO)
					end
				end, { buffer = b, desc = "Copy relative path" })
			end,
		})
	end,
}
