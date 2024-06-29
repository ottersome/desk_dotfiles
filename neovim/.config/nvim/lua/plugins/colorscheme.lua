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
		"frenzyexists/aquarium-vim",
		config = function()
			-- vim.cmd([[colorscheme aquarium]])
		end,
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
		config = function()
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
}
