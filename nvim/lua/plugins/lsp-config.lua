-- lua/plugins/lsp-config.lua
-- LSPサーバーはすべてNix (home.nix) で管理。Masonはインストール済みバイナリの
-- PATHブリッジとしてのみ使い、ensure_installed / automatic_installation は無効。
return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {},
			automatic_installation = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 重複起動を避けるため vtsls を明示的に無効化
			if vim.lsp.disable then
				vim.lsp.disable("vtsls")
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "vtsls" then
						vim.lsp.stop_client(client.id)
					end
				end,
			})

			-- サーバ個別の上書き/追加設定は vim.lsp.config
			vim.lsp.config("*", {
				capabilities = capabilities,
				cmd_env = { NODE_NO_WARNINGS = "1" },
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			-- ruby-lsp（solargraphより補完・定義ジャンプが安定）
			vim.lsp.config("ruby_lsp", {
				init_options = {
					enabledFeatures = {
						"codeActions",
						"completion",
						"definition",
						"diagnostics",
						"documentHighlights",
						"documentSymbols",
						"formatting",
						"hover",
						"inlayHint",
						"references",
						"rename",
						"signatureHelp",
					},
				},
			})

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
						},
						checkOnSave = true,
						check = {
							command = "clippy",
							extraArgs = { "--all-targets" },
						},
						procMacro = {
							enable = true,
						},
						inlayHints = {
							bindingModeHints = {
								enable = true,
							},
							closureCaptureHints = {
								enable = true,
							},
							closureReturnTypeHints = {
								enable = "always",
							},
							discriminantHints = {
								enable = "always",
							},
							lifetimeElisionHints = {
								enable = "skip_trivial",
								useParameterNames = true,
							},
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
				},
			})

			-- 有効化（solargraph → ruby_lsp に変更）
			vim.lsp.enable({ "lua_ls", "pyright", "ruby_lsp", "rubocop", "ts_ls", "rust_analyzer", "nil_ls" })
		end,
	},
}
