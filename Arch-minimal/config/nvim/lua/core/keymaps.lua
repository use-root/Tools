--------------------------------
------------------------------ LeaderMap: <Espace> :3
--------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------
------------------------------ Clipboard
--------------------------------

vim.keymap.set("v", "<C-i>", '"+y', { desc = "Copy visual to clipboard" })
vim.keymap.set("n", "<C-i>", '"+y', { desc = "Copy line to clipboard" })

vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-v>", "<C-R>+", { desc = "Paste from clipboard in insert mode" })

----------------
-------------- End Clipboard
----------------

--------------------------------
------------------------------ Files
--------------------------------

vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save the file" })
vim.keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and exit the file" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

---------------
------------- End Files
---------------

--------------------------------
------------------------------ Terminal
--------------------------------

local my_shell = vim.env.SHELL
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<leader>t", function()
	vim.cmd("botright split | term " .. my_shell)
	vim.cmd("resize 12")
	vim.cmd("startinsert")
end, { desc = "Back to normal mode in terminal" })

----------------
-------------- End Terminal
----------------

--------------------------------
------------------------------ Buffer
--------------------------------

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left buffer" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right buffer" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top buffer" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom buffer" })

vim.keymap.set("n", "<C-A-k>", ":resize +1<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-A-j>", ":resize -1<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-A-h>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-A-l>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<leader>vn", function()
	vim.ui.input({ prompt = "File name: " }, function(input)
		if input then
			local pwd = vim.fn.getcwd() .. "/"
			vim.cmd("vnew " .. pwd .. input)
		end
	end)
end, { desc = "Create new vertical split with file" })

---------------
------------- End Buffer
---------------

--------------------------------
------------------------------ Editing Config
--------------------------------

vim.keymap.set("n", "<leader>rc", ":e $MYVIMRC<CR>", { desc = "Edit main config file 'init.lua'" })
vim.keymap.set("n", "<leader>rl", ":so $MYVIMRC<CR>", { desc = "Reload config, make a source" })

---------------
------------- End Editting Config
---------------

--------------------------------
------------------------------ Files Explorer
--------------------------------

vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open native file explorer" })

---------------
------------- End File Explorer
---------------

--------------------------------
------------------------------ Telescope
--------------------------------

vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Find files default" })

vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Live grep (rg)" })

vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Help tags" })

vim.keymap.set("n", "<leader>fr", function()
	require("telescope.builtin").resume()
end, { desc = "Resume last search" })

vim.keymap.set("n", "<leader>fs", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Search current buffer" })

---------------
------------- End Telescope
---------------
local server_job = nil

vim.keymap.set("n", "<leader>lo", function()
	local file = vim.fn.expand("%:p")

	if server_job ~= nil then
		print("Server already running")
		return
	end

	server_job = vim.fn.jobstart({
		"live-server.sh",
		file,
	})
end, { desc = "Init live server" })

vim.keymap.set("n", "<leader>lc", function()
	if server_job then
		vim.fn.jobstop(server_job)
		server_job = nil
		print("Stop live server")
	end
end)
