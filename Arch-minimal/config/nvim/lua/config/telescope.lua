local actions = require("telescope.actions")
local telescope = require("telescope")
return function()
	telescope.setup({
		defaults = {
			layout_strategy = "center",
			path_display = { "smart" },
			file_ignore_patterns = { "node_modules", ".git/" },
			color_devicons = true,
			sorting_strategy = "ascending",
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			layout_config = {

				center = {
					height = 0.4,
					width = 0.6,
					preview_cutoff = 20,
					prompt_position = "top",
				},

				flex = { horizontal = { preview_width = 0.6 }, vertical = { preview_width = 0.8 } },
			},
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<C-d>"] = actions.delete_buffer,
					["<C-h>"] = actions.select_horizontal,
					["<C-e>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,
					["<C-/>"] = actions.which_key, -- Show all available mappings
					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				},
				n = {
					["q"] = actions.close,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["dd"] = actions.delete_buffer,
					["<C-h>"] = actions.select_horizontal,
					["<C-e>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,
				},
			},
		},
		pickers = {
			layout_strategy = "vertical",
			layout_config = {
				flex = {
					preview_width = 0.6,
					height = 0.9,
					width = 0.6,
				},
				vertical = {
					preview_width = 0.8,
					height = 0.9,
					width = 0.6,
				},
			},
		},
		buffers = {
			mappings = {
				n = {
					["dd"] = actions.delete_buffer,
				},
			},
		},
		live_grep = {},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})

	telescope.load_extension("fzf")
end
