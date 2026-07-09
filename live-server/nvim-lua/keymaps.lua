local server_job = nil

vim.keymap.set("n", "<leader>lo", function()
	local file = vim.fn.expand("%:p")

	if server_job ~= nil then
		print("Server already running")
		return
	end

	server_job = vim.fn.jobstart({
		"/scripts/live-server.sh",
		file,
	})

	print("PID:", vim.fn.jobpid(server_job))
end, { desc = "Init live server" })

vim.keymap.set("n", "<leader>lc", function()
	if server_job then
		vim.fn.jobstop(server_job)
		server_job = nil
		print("Stop live server")
	end
end)
