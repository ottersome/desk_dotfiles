local builtin = require("telescope.builtin")
local ts = require("telescope")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "Telescope: Git Files" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Telescope: Find string in cwd" })
-- TODO: Get somethign to search like 'fs' but only on tracked files
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Find open buffers" })
vim.keymap.set("n", "<leader>fd", builtin.grep_string, { desc = "Telescope: Find highlighted string under cwd" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Telescope: Commands" })
vim.keymap.set("n", "<leader>fr", builtin.command_history, { desc = "Telescope: Recent Commands" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope: Keymaps" })
vim.keymap.set("n", "<leader>fi", builtin.vim_options, { desc = "Telescope: Options" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope: Old Files" })
vim.keymap.set("n", "<leader>fl", builtin.colorscheme, { desc = "Telescope: Colorschemes" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help Tags" })
vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Telescope: Jump List" })
vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Telescope: Man Pages" })
vim.keymap.set("n", "<leader>fT", builtin.treesitter, { desc = "Telescope: Treesitter symbols" })
vim.keymap.set("n", "<leader>ft", builtin.lsp_dynamic_workspace_symbols, { desc = "Telescope: Treesitter symbols" })
-- Do notify
ts.load_extension("notify")
vim.keymap.set("n", "<leader>fn", ts.extensions.notify.notify, { desc = "Telescope: Notify" })
--vim.keymap.set('n','<leader>ps', function()
--		builtin.grep_string({ search = vim.fn.input("Grep > ") });
--	end)
