return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = {
					enable = true,
				},
				-- ensure these language parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"java",
					"tsx",
					"yaml",
					"html",
					"css",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"python",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "[x",
						node_incremental = "[x",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
	},
	{
		-- Depends on above.
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local ntt = require("nvim-treesitter.configs")
			ntt.setup({
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = { query = "@function.outer", desc = "TSTO: Next func start" },
							["]w"] = { query = "@class.outer", desc = "TSTO: Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
							-- LG: Not sure what this does
							-- ["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]q"] = { query = "@scope", query_group = "locals", desc = "TSTO: Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "TSTO: Next fold" },
						},
						goto_next_end = {
							["]F"] = { query = "@function.outer", desc = "TSTO: N/ func out end" },
							["]W"] = { query = "@class.outer", desc = "TSTO: N/ class out end" },
						},
						goto_previous_start = {
							["[f"] = { query = "@function.outer", desc = "TSTO: P/ func out start" },
							["[w"] = { query = "@class.outer", desc = "TSTO: P/ class out start" },
							["[q"] = { query = "@scope", query_group = "locals", desc = "TSTO: Next scope" },
						},
						goto_previous_end = {
							["[F"] = { query = "@function.outer", desc = "TSTO: P/ func out end" },
							["[W"] = { query = "@class.outer", desc = "TSTO: P/ class out end" },
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						-- goto_next = {
						-- 	["]d"] = "@conditional.outer",
						-- },
						-- goto_previous = {
						-- 	["[d"] = "@conditional.outer",
						-- },
					},
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "TSTO: Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "TSTO: Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "V", -- linewise
							-- ["@class.outer"] = "<c-v>", -- blockwise
						},
					},
				},
			})
		end,
	},
}
