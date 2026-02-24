return {
	-- Mason: LSP server installer
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},

	-- Mason-lspconfig: Bridge between Mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright", -- Py
					"clangd", -- C/C++
					"ts_ls", -- JS/Ts
					"eslint",
					"lua_ls", -- Lua
					"marksman", -- Md
				},
				automatic_installation = true,
				handlers = {
					function(server_name)
						-- C/C++ with clangd
						if server_name == "clangd" then
							require("lspconfig").clangd.setup({
								capabilities = capabilities,
								cmd = {
									"clangd",
									"--background-index",
									"--clang-tidy",
									"--header-insertion=iwyu",
									"--completion-style=detailed",
									"--function-arg-placeholders",
								},
								init_options = {
									usePlaceholders = true,
									completeUnimported = true,
									clangdFileStatus = true,
								},
							})
						-- Python with pyright
						elseif server_name == "pyright" then
							require("lspconfig").pyright.setup({
								capabilities = capabilities,
								settings = {
									python = {
										analysis = {
											typeCheckingMode = "basic",
											autoSearchPaths = true,
											useLibraryCodeForTypes = true,
											diagnosticMode = "workspace",
										},
									},
								},
							})
						-- Lua with lua_ls
						elseif server_name == "lua_ls" then
							require("lspconfig").lua_ls.setup({
								capabilities = capabilities,
								settings = {
									Lua = {
										runtime = { version = "LuaJIT" },
										diagnostics = { globals = { "vim" } },
										workspace = {
											library = vim.api.nvim_get_runtime_file("", true),
											checkThirdParty = false,
										},
										telemetry = { enable = false },
									},
								},
							})
						-- Default handler for all other servers
						else
							require("lspconfig")[server_name].setup({
								capabilities = capabilities,
							})
						end
					end,
				},
			})

			-- LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
				callback = function(args)
					local opts = { buffer = args.buf, noremap = true, silent = true }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				end,
			})

			-- Show diagnostics on hover
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { focusable = false })
				end,
			})
		end,
	},
}
