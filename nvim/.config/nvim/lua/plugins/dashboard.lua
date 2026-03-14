return {
	{
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			vim.api.nvim_set_hl(0, "AlphaPurple", { fg = "#cba6f7", bold = true })

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
				dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
				dashboard.button("f", "󰈞  Find file", "<cmd>FzfLua files<CR>"),
				dashboard.button("r", "  Recent files", "<cmd>FzfLua oldfiles<CR>"),
				dashboard.button("g", "󰊄  Live grep", "<cmd>FzfLua live_grep<CR>"),
				dashboard.button("c", "  Config", "<cmd>FzfLua files cwd=~/.config/nvim/<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}
			dashboard.section.buttons.opts.hl = "Keyword"

			-- Footer with string formatting
			dashboard.section.footer.val = function()
				local stats = require("lazy").stats()
				local ms = string.format("%.2f", stats.startuptime)
				local plugins = "󱉧 " .. stats.loaded .. "/" .. stats.count
				local load_time = "󰅐 " .. ms .. "ms"
				local version = " " .. vim.version().major .. "." .. vim.version().minor

				return "  " .. plugins .. "  │  " .. load_time .. "  │  " .. version
			end
			dashboard.section.footer.opts.hl = "Comment"

			-- Centering logic
			local function get_padding()
				local total_h = #dashboard.section.header.val + 2 + #dashboard.section.buttons.val + 2 + 1
				return math.max(0, math.floor((vim.o.lines - total_h) / 2) - 4)
			end

			dashboard.config.layout = {
				{ type = "padding", val = get_padding() },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 2 },
				dashboard.section.footer,
			}

			local group = vim.api.nvim_create_augroup("AlphaSetup", { clear = true })

			-- Hide UI on dashboard
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "alpha",
				callback = function()
					vim.opt_local.laststatus = 0
					vim.opt_local.showtabline = 0
					vim.opt_local.signcolumn = "no"
					vim.opt_local.modifiable = false
				end,
			})
			-- Restore UI on exit
			vim.api.nvim_create_autocmd("BufUnload", {
				group = group,
				buffer = 0,
				callback = function()
					vim.opt.showtabline = 2
					vim.opt.signcolumn = "yes"
				end,
			})

			-- Handle terminal resize
			vim.api.nvim_create_autocmd("VimResized", {
				group = group,
				callback = function()
					if vim.bo.filetype == "alpha" then
						dashboard.config.layout[1].val = get_padding()
						alpha.redraw()
					end
				end,
			})

			alpha.setup(dashboard.config)
		end,
	},
}
