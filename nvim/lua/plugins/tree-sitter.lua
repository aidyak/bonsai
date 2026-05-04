return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = true,
		priority = 1000,
		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"json",
					"yaml",
					"markdown",
				"markdown_inline",
				"mdx",
					"javascript",
					"typescript",
					"python",
					"rust",
					"toml",
				},
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}
