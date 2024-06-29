return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<C-s>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					debounce = 75,
					keymap = {
						accept = "<C-J>",
						accept_word = false,
						accept_line = false,
						next = "<C-L>",
						prev = "<C-H>",
						dismiss = "<C-d>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 16.x
				server_opts_overrides = {},
			})
		end,
	},
	{ --For Chat
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			-- Path to Nvim
			local path = vim.fn.expand("$HOME") .. "/.config/openai/"
			local keymap = vim.keymap
			keymap.set("n", "<leader>cc", ":ChatGPT <CR>", { desc = "Chat" })
			keymap.set({ "n", "v" }, "<leader>ce", ":ChatGPTEditWithInstructions <CR>", { desc = "GPT Edit" })
			keymap.set("n", "<leader>ca", ":ChatGPTRun <CR>", { desc = "GPT Run" })
			-- Map for normal AND visual mode

			require("chatgpt").setup({
				api_key_cmd = "gpg --decrypt " .. path .. "secret.key.gpg",
				openai_params = {
					model = "gpt-4-turbo",
					frequency_penalty = 0,
					presence_penalty = 0,
					max_tokens = 300,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				openai_edit_params = {
					model = "gpt-4",
					frequency_penalty = 0,
					presence_penalty = 0,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				actions_path = {
					path .. "actions/",
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	--{
	--"zbirenbaum/copilot-cmp",
	--config = function()
	--require("copilot_cmp").setup({})
	--end,
	--},
}
