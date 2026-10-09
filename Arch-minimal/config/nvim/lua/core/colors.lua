local transparent = {
	"Normal",
	"NormalNC",
	"SignColumn",
	"EndOfBuffer",
	"StatusLine",
	"TabLine",
}

for _, group in ipairs(transparent) do
	vim.api.nvim_set_hl(0, group, { bg = "none" })
end

-- BG of the Interface of Telescope
vim.cmd([[
hi TelescopeNormal guibg=NONE
hi TelescopeBorder guibg=NONE
hi TelescopePromptNormal guibg=NONE
hi TelescopePromptBorder guibg=NONE
hi TelescopePreviewNormal guibg=NONE
hi TelescopePreviewBorder guibg=NONE
hi TelescopeResultsNormal guibg=NONE
hi TelescopeResultsBorder guibg=NONE
]])
