---@type vim.lsp.Config
return {
	settings = {
		Lua = {
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
			hint = {
				enable = true,
				arrayIndex = 'Disable',
			},
		},
	},
}
