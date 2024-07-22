return {
	{ "rebelot/kanagawa.nvim" },
	{
		"nordtheme/vim",
		name = "nord",
		--config = function()
		--vim.cmd([[colorscheme nord]])
		--end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		-- config = function()
		-- 	require("nordic").load()
		-- end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"AlessandroYorba/Alduin",
		name = "alduin",
		config = function()
			vim.g.alduin_Shout_Dragon_Aspect = true
			vim.cmd([[colorscheme alduin]])
		end,
	},
	-- { "jdsimcoe/abstract.vim" },
}
