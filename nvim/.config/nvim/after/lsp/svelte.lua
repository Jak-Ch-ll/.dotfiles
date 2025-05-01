---@type vim.lsp.Config
return {
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = {
					enabled = true,
				},
				parameterTypes = {
					enabled = true,
				},
				variableTypes = {
					enabled = true,
				},
				propertyDeclarationTypes = {
					enabled = true,
				},
				functionLikeReturnTypes = {
					-- for some reason inlay hints break for
					-- svelte lsp when this is enabled
					-- @todo need to investigate further
					enabled = false,
				},
				enumMemberValues = {
					enabled = true,
				},
			},
		},
	},
}
