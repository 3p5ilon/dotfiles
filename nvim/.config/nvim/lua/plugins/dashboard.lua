return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			vim.api.nvim_set_hl(0, "AlphaPurple", { fg = "#cba6f7" })

			dashboard.section.header.val = {
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
			}
			dashboard.section.header.opts.hl = "AlphaPurple"

			-- Dashboard Buttons
			dashboard.section.buttons.val = {
				dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
				dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
				dashboard.button("g", "󰊄  Live grep", ":Telescope live_grep<CR>"),
				dashboard.button("c", "  Config", ":Telescope find_files cwd=~/.config/nvim/<CR>"),
				dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
			}
			dashboard.section.buttons.opts.hl = "Keyword"

			local function get_recent_files()
				local files = {}
				local oldfiles = vim.v.oldfiles or {}
				for i = 1, math.min(5, #oldfiles) do
					local file = oldfiles[i]
					if vim.fn.filereadable(file) == 1 then
						table.insert(files, {
							type = "text",
							val = string.format("  %d. %s", i, vim.fn.fnamemodify(file, ":~")),
							opts = { hl = "Normal" },
							on_press = function()
								vim.cmd("edit " .. file)
							end,
						})
					end
				end
				return files
			end

			-- Footer with lazy.nvim stats
			local function footer()
				local stats = require("lazy").stats()
				local plugins = "󱉧 " .. stats.loaded .. "/" .. stats.count
				local uptime = "󰅐 " .. string.format("%.2f", vim.loop.hrtime() / 1e9) .. "s"
				local version = " " .. vim.version().major .. "." .. vim.version().minor
				return "  " .. plugins .. "  |  " .. uptime .. "  |  " .. version
			end
			dashboard.section.footer.val = footer()
			dashboard.section.footer.opts.hl = "Comment"

			-- Vertical centering
			local function get_center_padding()
				local total_lines = vim.o.lines
				local content_height = #dashboard.section.header.val + 15
				return math.max(1, math.floor((total_lines - content_height) / 2) - 3)
			end

			dashboard.config.layout = {
				{ type = "padding", val = get_center_padding },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 2 },
				{ type = "group", val = get_recent_files() },
				{ type = "padding", val = 2 },
				dashboard.section.footer,
			}

			-- Disable scroll and UI elements when dashboard is open
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "alpha",
				callback = function()
					vim.opt_local.wrap = false
					vim.opt_local.scrolloff = 0
					vim.opt_local.laststatus = 0
					vim.opt_local.showtabline = 0
					vim.opt_local.signcolumn = "no"
					vim.bo.modifiable = false
				end,
			})

			-- Restore UI elements when leaving dashboard
			vim.api.nvim_create_autocmd("BufUnload", {
				buffer = 0,
				callback = function()
					vim.opt.laststatus = 3
					vim.opt.showtabline = 2
				end,
			})

			alpha.setup(dashboard.config)
		end,
	},
}
