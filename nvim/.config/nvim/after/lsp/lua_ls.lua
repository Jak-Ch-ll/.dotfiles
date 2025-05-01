---@type vim.lsp.Config
return {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if
			vim.loop.fs_stat(path .. '/.luarc.json')
			or vim.loop.fs_stat(path .. '/.luarc.jsonc')
		then
			return
		end

		client.config.settings.Lua =
			---@diagnostic disable-next-line: param-type-mismatch
			vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					version = 'LuaJIT',
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
				diagnostics = {
					disable = { 'undefined-field' },
				},
			})
	end,
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
