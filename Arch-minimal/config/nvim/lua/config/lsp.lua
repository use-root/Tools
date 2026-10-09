local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
	ts_ls = {},
	pyright = {},
	lua_ls = {
		settings = {
			Lua = { diagnostics = { globals = { "vim" } } },
		},
	},
	html = {},
	cssls = {},
	jsonls = {},
	clangd = {},
	ccls = {},
	jdtls = {},
	bashls = {},
}

for server, config in pairs(servers) do
	vim.lsp.config[server] = vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, config)

	vim.lsp.enable(server)
end

vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
	config = config or {}
	config.border = "rounded"
	config.focusable = false
	config.winblend = 20
	config.max_width = 80
	config.max_height = 20
	return vim.lsp.handlers.hover(err, result, ctx, config)
end

vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
	config = config or {}
	config.border = "rounded"
	config.focusable = false
	config.winblend = 20
	config.max_width = 80
	config.max_height = 20
	return vim.lsp.handlers.signature_help(err, result, ctx, config)
end

vim.diagnostic.config({
	float = {
		border = "rounded",
		max_width = 90,
		max_height = 25,
		focusable = true,
		source = "always",
	},
})
