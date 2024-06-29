-- Allows us to see buffers as tabs. Technically not using tabs 😛
return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	commit = "73540cb",
	opts = {
		options = {
			separator_style = "slant",
		},
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({})
		--
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>b", ":BufferLinePick<CR>", { desc = "Use BufferLine plugin to pick buffer." }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>-",
			":BufferLinePickClose<CR>",
			{ desc = "Use BufferLine plugin to pick buffer to close." }
		) -- toggle file explorer
		keymap.set("n", "<leader>h", ":BufferLineCyclePrev<CR>", { desc = "Bufferline: Go to left tab." }) -- toggle file explorer
		keymap.set("n", "<leader>l", ":BufferLineCycleNext<CR>", { desc = "Bufferline: Go to right tab." }) -- toggle file explorer
		keymap.set("n", "<C-h>", ":BufferLineMovePrev<CR>", { desc = "Bufferline: Move tab to the left." }) -- toggle file explorer
		keymap.set("n", "<C-l>", ":BufferLineMoveNext<CR>", { desc = "Bufferline: Move tab to the right." }) -- toggle file explorer
	end,
}
