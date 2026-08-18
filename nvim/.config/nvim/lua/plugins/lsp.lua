return {
	-- Mason: core installer UI
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},

	-- Mason Tool Installer: auto-installs formatters + linters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- formatters
				"stylua",
				"black",
				"isort",
				"clang-format",
				"prettierd",
				"gofumpt",
				"goimports",

				-- linters
				"pylint",
			},
			run_on_start = true,
		},
	},

	-- Mason LSP Bridge: auto-installs + enables LSP servers
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- Global capabilities via blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Lua
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = { enable = false },
					},
				},
			})

			-- Python
			vim.lsp.config("pyright", {
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

			-- C/C++: utf-16 required by clangd
			local clangd_capabilities = vim.deepcopy(capabilities)
			clangd_capabilities.offsetEncoding = { "utf-16" }

			vim.lsp.config("clangd", {
				capabilities = clangd_capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=bundled",
					"--function-arg-placeholders=true",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			})

			-- TS/JS
			vim.lsp.config("ts_ls", {})

			-- ESLint: JS/TS linting via LSP
			vim.lsp.config("eslint", {})

			-- Markdown
			vim.lsp.config("marksman", {})

			-- Rust: rust-analyzer handles formatting & linting
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = true,
						check = {
							command = "clippy",
						},
						cargo = { allFeatures = true },
					},
				},
			})

			-- Go
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
					},
				},
			})

			-- Install servers + auto-start on attach
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
					"ts_ls",
					"eslint",
					"marksman",
					"rust_analyzer",
					"gopls",
				},
				automatic_enable = true,
			})

			-- Keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
				callback = function(args)
					local opts = function(desc)
						return { buffer = args.buf, silent = true, desc = desc }
					end

					-- Navigation
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
					vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts("Go to implementation"))
					vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts("Go to type definition"))
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Show references"))
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
					vim.keymap.set("n", "<leader>cs", vim.lsp.buf.workspace_symbol, opts("Workspace symbols"))

					-- Code operations
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code actions"))
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename symbol (LSP)"))
					vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts("Line diagnostics"))
					vim.keymap.set("n", "<leader>cf", function()
						vim.lsp.buf.format({ async = true })
					end, opts("Format buffer"))

					-- Diagnostics Navigation
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1 })
					end, opts("Previous diagnostic"))
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1 })
					end, opts("Next diagnostic"))
					vim.keymap.set("n", "[e", function()
						vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
					end, opts("Previous error"))
					vim.keymap.set("n", "]e", function()
						vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
					end, opts("Next error"))
				end,
			})

			-- Diagnostics
			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					prefix = "●",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰌵 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})
		end,
	},
}
